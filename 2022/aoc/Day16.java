package aoc;

import static com.google.common.collect.ImmutableList.toImmutableList;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.google.common.base.Splitter;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;

public class Day16 {
  private static final Splitter COMMA_SPLITTER = Splitter.on(",").trimResults();
  static int distances[][];

  static void updateDistances() {
    int len = nodes.size();
    distances = new int[len][len];
    for (int i = 0; i < len; ++i) {
      for (int j = 0; j < len; ++j) {
        distances[i][j] = 100000;
      }
    }
    for (Node node : nodes.values()) {
      int from = node.index;
      distances[from][from] = 0;
      for (Node neighbor : node.neighbors) {
        int to = neighbor.index;
        distances[from][to] = 1;
      }
    }
    //    System.out.printf("    ");
    //    for (int i = 0; i < len; ++i) {
    //      System.out.printf("%s ", nodeArr[i].name);
    //    }
    //    System.out.println();
    //
    //    for (int i = 0; i < len; ++i) {
    //      System.out.printf("%s: ", nodeArr[i].name);
    //      for (int j = 0; j < len; ++j) {
    //        System.out.printf("%d  ", distances[i][j]);
    //      }
    //      System.out.println();
    //    }

    // FW
    for (int k = 0; k < len; ++k) {
      for (int i = 0; i < len; ++i) {
        for (int j = 0; j < len; ++j) {
          // DAVUQ?
          if (distances[i][j] > distances[i][k] + distances[k][j]) {
            distances[i][j] = distances[i][k] + distances[k][j];
          }
        }
      }
    }

    //    System.out.printf("    ");
    //    for (int i = 0; i < len; ++i) {
    //      System.out.printf("%s ", nodeArr[i].name);
    //    }
    //    System.out.println();
    //
    //    for (int i = 0; i < len; ++i) {
    //      System.out.printf("%s: ", nodeArr[i].name);
    //      for (int j = 0; j < len; ++j) {
    //        System.out.printf("%d  ", distances[i][j]);
    //      }
    //      System.out.println();
    //    }
  }

  public static class Node {
    String name;
    int index;
    int flowrate;
    List<Node> neighbors = new ArrayList<>();
    List<String> neighborNames = new ArrayList<>();
  }

  static Node[] nodeArr;
  static Map<String, Node> nodes = new HashMap<>();

  public static class State {
    public State(Node node, int time, int score, Set<String> opened, List<String> ordered) {
      this.node = node;
      this.time = time;
      this.score = score;
      this.opened = opened;
      this.ordered = ordered;
    }

    @Override
    public String toString() {
      return String.format(
          "Node: %s T: %d Score %d opened %s", node.name, time, score, ordered.toString());
    }

    Node node;
    int time;
    int score;
    Set<String> opened;
    List<String> ordered;
  }

  static Pattern pattern =
      Pattern.compile("Valve ([A-Z][A-Z]) has flow rate=(\\d+); tunnels? leads? to valves? (.*)$");

  static Map<String, Node> parse(String[] input) {
    nodeArr = new Node[input.length];
    int i = 0;
    for (String line : input) {
      Node node = parse(line);
      nodeArr[i] = node;
      node.index = i++;
      nodes.put(node.name, node);
    }
    for (Node node : nodes.values()) {
      node.neighbors =
          node.neighborNames.stream().map(name -> nodes.get(name)).collect(toImmutableList());
    }
    return nodes;
  }

  static Node parse(String input) {
    // Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
    Node node = new Node();
    Matcher m = pattern.matcher(input);
    m.matches();
    node.name = m.group(1);
    node.flowrate = Integer.parseInt(m.group(2));
    String neighbors = m.group(3);
    node.neighborNames = COMMA_SPLITTER.splitToList(neighbors);
    return node;
  }

  static void bfs() {
    List<State> queue = new ArrayList<>();
    queue.add(new State(nodes.get("AA"), 1, 0, ImmutableSet.of(), ImmutableList.of()));
    int best = 0;
    List<String> sequence = null;
    while (!queue.isEmpty()) {
      State head = queue.remove(0);
      //      System.out.printf("Popped %s\n", head);
      if (head.score > best) {
        best = Math.max(best, head.score);
        sequence = head.ordered;
        //        System.out.println("Best so far: " + sequence);
      }
      //      List<Node> neighbors = head.node.neighbors;
      // do we look at ALL neighbors?
      for (Node n : nodes.values()) {
        // 1. find neighbors
        // 2. remove opened neighbors
        // 3. remove neighbors we can't get to in time
        if (n.flowrate > 0 && !head.opened.contains(n.name)) {
          int distance = distances[head.node.index][n.index]; // distnace between 'head' and 'node'
          int newtime = head.time + distance + 1;
          if (newtime <= 30) {
            // newtime - 1?
            int newscore = head.score + (31 - newtime) * n.flowrate;
            Set<String> newopened = new HashSet<String>(head.opened);
            newopened.add(n.name);
            List<String> newordered = new ArrayList<String>(head.ordered);
            newordered.add(n.name);
            State newState = new State(n, newtime, newscore, newopened, newordered);
            //            System.out.printf("Pushing %s\n", newState);
            queue.add(newState);
          }
        }
      }
      //      System.out.printf("Queue: %s\n", queue);
    }
    System.out.println("Sequence: " + sequence);
    System.out.println("Max " + best);
  }
}
