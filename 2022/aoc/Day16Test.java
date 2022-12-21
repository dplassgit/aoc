package aoc;

import static com.google.common.truth.Truth.assertThat;

import java.util.Map;

import org.junit.Test;

import aoc.Day16.Node;

public class Day16Test {

  String input =
      "Valve AA has flow rate=0; tunnels lead to valves DD, II, BB\n"
          + "Valve BB has flow rate=13; tunnels lead to valves CC, AA\n"
          + "Valve CC has flow rate=2; tunnels lead to valves DD, BB\n"
          + "Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE\n"
          + "Valve EE has flow rate=3; tunnels lead to valves FF, DD\n"
          + "Valve FF has flow rate=0; tunnels lead to valves EE, GG\n"
          + "Valve GG has flow rate=0; tunnels lead to valves FF, HH\n"
          + "Valve HH has flow rate=22; tunnel leads to valve GG\n"
          + "Valve II has flow rate=0; tunnels lead to valves AA, JJ\n"
          + "Valve JJ has flow rate=21; tunnel leads to valve II";

  @Test
  public void updateDistances() {
    Map<String, Node> nodes = Day16.parse(input.split("\n"));
    Day16.updateDistances();
    Day16.bfs();
  }

  @Test
  public void parseAll() {
    Map<String, Node> nodes = Day16.parse(input.split("\n"));
    assertThat(nodes).hasSize(10);
    Node aa = nodes.get("AA");
    assertThat(aa.flowrate).isEqualTo(0);
    assertThat(aa.index).isEqualTo(0);
    assertThat(aa.neighborNames).containsExactly("DD", "II", "BB");
    assertThat(aa.neighbors).containsExactly(nodes.get("DD"), nodes.get("II"), nodes.get("BB"));
    Node bb = nodes.get("BB");
    assertThat(bb.index).isEqualTo(1);
    assertThat(bb.flowrate).isEqualTo(13);
    assertThat(bb.neighborNames).containsExactly("CC", "AA");
    assertThat(bb.neighbors).containsExactly(nodes.get("CC"), aa);
  }

  @Test
  public void parse() {
    Node node = Day16.parse("Valve QI has flow rate=5; tunnels lead to valves TX, NC, QS, HY, UX");
    assertThat(node.name).isEqualTo("QI");
    assertThat(node.flowrate).isEqualTo(5);
    assertThat(node.neighborNames).containsExactly("TX", "NC", "QS", "HY", "UX").inOrder();
  }

  @Test
  public void parseOneDestination() {
    Node node = Day16.parse("Valve SJ has flow rate=23; tunnels lead to valve FP");
    assertThat(node.name).isEqualTo("SJ");
    assertThat(node.flowrate).isEqualTo(23);
    assertThat(node.neighborNames).containsExactly("FP").inOrder();
  }
}
