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
import com.google.common.collect.ImmutableSet;

public class Day16 {
  private static final Splitter COMMA_SPLITTER = Splitter.on(",").trimResults();

  Day16(String[] input) {
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
  }

  int distances[][];

  void updateDistances() {
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
    printMatrix(len);

    // FW
    for (int k = 0; k < len; ++k) {
      for (int i = 0; i < len; ++i) {
        for (int j = 0; j < len; ++j) {
          if (distances[i][j] > distances[i][k] + distances[k][j]) {
            distances[i][j] = distances[i][k] + distances[k][j];
          }
        }
      }
    }

    printMatrix(len);
  }

  private void printMatrix(int len) {
    System.out.printf("    ");
    for (int i = 0; i < len; ++i) {
      System.out.printf("%s ", nodeArr[i].name);
    }
    System.out.println();

    for (int i = 0; i < len; ++i) {
      System.out.printf("%s: ", nodeArr[i].name);
      for (int j = 0; j < len; ++j) {
        System.out.printf("%d  ", distances[i][j]);
      }
      System.out.println();
    }
  }

  public static class Node {
    String name;
    int index;
    int flowrate;
    List<Node> neighbors = new ArrayList<>();
    List<String> neighborNames = new ArrayList<>();
  }

  Node[] nodeArr;
  Map<String, Node> nodes = new HashMap<>();

  public static class State {
    public State(Node node, int time, int score, Set<String> opened) {
      this.node = node;
      this.time = time;
      this.score = score;
      this.opened = opened;
    }

    @Override
    public String toString() {
      return String.format("Node: %s T: %d Score %d opened %s", node.name, time, score);
    }

    Node node;
    int time;
    int score;
    Set<String> opened;
  }

  static Pattern pattern =
      Pattern.compile("Valve ([A-Z][A-Z]) has flow rate=(\\d+); tunnels? leads? to valves? (.*)$");

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

  int part1() {
    updateDistances();

    List<State> queue = new ArrayList<>();
    queue.add(new State(nodes.get("AA"), 1, 0, ImmutableSet.of()));
    int best = 0;
    while (!queue.isEmpty()) {
      State head = queue.remove(0);
      //      System.out.printf("Popped %s\n", head);
      if (head.score > best) {
        best = Math.max(best, head.score);
        //        System.out.println("Best so far: " + best);
      }
      // look at ALL nodes
      for (Node n : nodes.values()) {
        // Only use openable nodes
        if (n.flowrate > 0 && !head.opened.contains(n.name)) {
          int distance = distances[head.node.index][n.index]; // distnace between 'head' and 'node'
          int newtime = head.time + distance + 1;
          if (newtime <= 30) {
            // We can get there in time.
            int newscore = head.score + (31 - newtime) * n.flowrate;
            Set<String> newopened = new HashSet<String>(head.opened);
            newopened.add(n.name);
            State newState = new State(n, newtime, newscore, newopened);
            //            System.out.printf("Pushing %s\n", newState);
            queue.add(newState);
          }
        }
      }
      //      System.out.printf("Queue: %s\n", queue);
    }
    System.out.println("Max " + best);
    return best;
  }
}
