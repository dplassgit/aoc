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

  String big =
      "Valve OM has flow rate=0; tunnels lead to valves AA, EZ\r\n"
          + "Valve ZZ has flow rate=0; tunnels lead to valves LR, QY\r\n"
          + "Valve NC has flow rate=0; tunnels lead to valves KX, QI\r\n"
          + "Valve QI has flow rate=5; tunnels lead to valves TX, NC, QS, HY, UX\r\n"
          + "Valve QS has flow rate=0; tunnels lead to valves CY, QI\r\n"
          + "Valve FP has flow rate=0; tunnels lead to valves IW, SJ\r\n"
          + "Valve ZR has flow rate=0; tunnels lead to valves ID, KC\r\n"
          + "Valve YR has flow rate=21; tunnels lead to valves RS, OT, FV\r\n"
          + "Valve SJ has flow rate=23; tunnel leads to valve FP\r\n"
          + "Valve QY has flow rate=0; tunnels lead to valves ZZ, NU\r\n"
          + "Valve KD has flow rate=13; tunnels lead to valves WY, ZP\r\n"
          + "Valve GT has flow rate=0; tunnels lead to valves SG, PD\r\n"
          + "Valve DB has flow rate=0; tunnels lead to valves TX, MX\r\n"
          + "Valve KW has flow rate=0; tunnels lead to valves AK, HM\r\n"
          + "Valve TX has flow rate=0; tunnels lead to valves QI, DB\r\n"
          + "Valve YX has flow rate=0; tunnels lead to valves HY, AA\r\n"
          + "Valve NA has flow rate=0; tunnels lead to valves NU, KS\r\n"
          + "Valve ST has flow rate=0; tunnels lead to valves YO, PD\r\n"
          + "Valve UX has flow rate=0; tunnels lead to valves QI, OT\r\n"
          + "Valve OT has flow rate=0; tunnels lead to valves UX, YR\r\n"
          + "Valve AK has flow rate=0; tunnels lead to valves KW, PD\r\n"
          + "Valve UC has flow rate=0; tunnels lead to valves YH, KC\r\n"
          + "Valve FF has flow rate=0; tunnels lead to valves YO, IN\r\n"
          + "Valve GN has flow rate=0; tunnels lead to valves CY, MX\r\n"
          + "Valve KK has flow rate=0; tunnels lead to valves WY, YO\r\n"
          + "Valve PD has flow rate=10; tunnels lead to valves GT, ID, HW, ST, AK\r\n"
          + "Valve LR has flow rate=18; tunnels lead to valves ZZ, NM, SG, YK\r\n"
          + "Valve CY has flow rate=14; tunnels lead to valves VB, GN, QS, FV\r\n"
          + "Valve YH has flow rate=0; tunnels lead to valves UC, VQ\r\n"
          + "Valve RS has flow rate=0; tunnels lead to valves MX, YR\r\n"
          + "Valve YO has flow rate=20; tunnels lead to valves FF, NM, KK, ST, ZU\r\n"
          + "Valve HQ has flow rate=0; tunnels lead to valves AA, MX\r\n"
          + "Valve UE has flow rate=0; tunnels lead to valves HM, IN\r\n"
          + "Valve NM has flow rate=0; tunnels lead to valves LR, YO\r\n"
          + "Valve KX has flow rate=7; tunnels lead to valves NC, UZ, XK, PV\r\n"
          + "Valve IW has flow rate=0; tunnels lead to valves VQ, FP\r\n"
          + "Valve IN has flow rate=22; tunnels lead to valves FF, UE\r\n"
          + "Valve WY has flow rate=0; tunnels lead to valves KK, KD\r\n"
          + "Valve HY has flow rate=0; tunnels lead to valves YX, QI\r\n"
          + "Valve AA has flow rate=0; tunnels lead to valves KS, OM, XO, HQ, YX\r\n"
          + "Valve ZU has flow rate=0; tunnels lead to valves YO, NU\r\n"
          + "Valve YK has flow rate=0; tunnels lead to valves ZP, LR\r\n"
          + "Valve XK has flow rate=0; tunnels lead to valves XO, KX\r\n"
          + "Valve VB has flow rate=0; tunnels lead to valves CY, UZ\r\n"
          + "Valve ZP has flow rate=0; tunnels lead to valves KD, YK\r\n"
          + "Valve VQ has flow rate=11; tunnels lead to valves YH, IW, EZ\r\n"
          + "Valve HW has flow rate=0; tunnels lead to valves NU, PD\r\n"
          + "Valve NU has flow rate=8; tunnels lead to valves ZU, UD, NA, HW, QY\r\n"
          + "Valve UZ has flow rate=0; tunnels lead to valves KX, VB\r\n"
          + "Valve PV has flow rate=0; tunnels lead to valves DY, KX\r\n"
          + "Valve MX has flow rate=6; tunnels lead to valves HQ, DB, DY, RS, GN\r\n"
          + "Valve KS has flow rate=0; tunnels lead to valves NA, AA\r\n"
          + "Valve UD has flow rate=0; tunnels lead to valves NU, IO\r\n"
          + "Valve FV has flow rate=0; tunnels lead to valves YR, CY\r\n"
          + "Valve SG has flow rate=0; tunnels lead to valves LR, GT\r\n"
          + "Valve HM has flow rate=24; tunnels lead to valves KW, UE\r\n"
          + "Valve XO has flow rate=0; tunnels lead to valves AA, XK\r\n"
          + "Valve KC has flow rate=12; tunnels lead to valves IO, UC, ZR\r\n"
          + "Valve IO has flow rate=0; tunnels lead to valves UD, KC\r\n"
          + "Valve DY has flow rate=0; tunnels lead to valves PV, MX\r\n"
          + "Valve ID has flow rate=0; tunnels lead to valves PD, ZR\r\n"
          + "Valve EZ has flow rate=0; tunnels lead to valves VQ, OM\r\n";

  @Test
  public void bfs() {
    Map<String, Node> nodes = Day16.parse(input.split("\n"));
    Day16.updateDistances();
    Day16.bfs();
  }

  @Test
  public void updateBigDistances() {
    Map<String, Node> nodes = Day16.parse(big.split("\r\n"));
    Day16.updateDistances();
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
