package aoc;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.google.common.base.Splitter;
import com.google.common.collect.Lists;

public class Day11 {
  private static final String BIG =
      "Monkey 0:\n"
          + "  Starting items: 65, 78\n"
          + "  Operation: new = old * 3\n"
          + "  Test: divisible by 5\n"
          + "    If true: throw to monkey 2\n"
          + "    If false: throw to monkey 3\n"
          + "\n"
          + "Monkey 1:\n"
          + "  Starting items: 54, 78, 86, 79, 73, 64, 85, 88\n"
          + "  Operation: new = old + 8\n"
          + "  Test: divisible by 11\n"
          + "    If true: throw to monkey 4\n"
          + "    If false: throw to monkey 7\n"
          + "\n"
          + "Monkey 2:\n"
          + "  Starting items: 69, 97, 77, 88, 87\n"
          + "  Operation: new = old + 2\n"
          + "  Test: divisible by 2\n"
          + "    If true: throw to monkey 5\n"
          + "    If false: throw to monkey 3\n"
          + "\n"
          + "Monkey 3:\n"
          + "  Starting items: 99\n"
          + "  Operation: new = old + 4\n"
          + "  Test: divisible by 13\n"
          + "    If true: throw to monkey 1\n"
          + "    If false: throw to monkey 5\n"
          + "\n"
          + "Monkey 4:\n"
          + "  Starting items: 60, 57, 52\n"
          + "  Operation: new = old * 19\n"
          + "  Test: divisible by 7\n"
          + "    If true: throw to monkey 7\n"
          + "    If false: throw to monkey 6\n"
          + "\n"
          + "Monkey 5:\n"
          + "  Starting items: 91, 82, 85, 73, 84, 53\n"
          + "  Operation: new = old + 5\n"
          + "  Test: divisible by 3\n"
          + "    If true: throw to monkey 4\n"
          + "    If false: throw to monkey 1\n"
          + "\n"
          + "Monkey 6:\n"
          + "  Starting items: 88, 74, 68, 56\n"
          + "  Operation: new = old * old\n"
          + "  Test: divisible by 17\n"
          + "    If true: throw to monkey 0\n"
          + "    If false: throw to monkey 2\n"
          + "\n"
          + "Monkey 7:\n"
          + "  Starting items: 54, 82, 72, 71, 53, 99, 67\n"
          + "  Operation: new = old + 1\n"
          + "  Test: divisible by 19\n"
          + "    If true: throw to monkey 6\n"
          + "    If false: throw to monkey 0\n"
          + "\n";
  private static final String SMALL =
      "Monkey 0:\n"
          + "  Starting items: 79, 98\n"
          + "  Operation: new = old * 19\n"
          + "  Test: divisible by 23\n"
          + "    If true: throw to monkey 2\n"
          + "    If false: throw to monkey 3\n"
          + "\n"
          + "Monkey 1:\n"
          + "  Starting items: 54, 65, 75, 74\n"
          + "  Operation: new = old + 6\n"
          + "  Test: divisible by 19\n"
          + "    If true: throw to monkey 2\n"
          + "    If false: throw to monkey 0\n"
          + "\n"
          + "Monkey 2:\n"
          + "  Starting items: 79, 60, 97\n"
          + "  Operation: new = old * old\n"
          + "  Test: divisible by 13\n"
          + "    If true: throw to monkey 1\n"
          + "    If false: throw to monkey 3\n"
          + "\n"
          + "Monkey 3:\n"
          + "  Starting items: 74\n"
          + "  Operation: new = old + 3\n"
          + "  Test: divisible by 17\n"
          + "    If true: throw to monkey 0\n"
          + "    If false: throw to monkey 1\n"
          + "\n";

  enum Operation {
    Add,
    Mult,
    Square;
  }

  public static class Monkey {
    private static final BigDecimal THREE = new BigDecimal(3);

    int num;
    List<BigDecimal> items = new ArrayList<>();
    Operation op;
    BigDecimal factor;
    BigDecimal test;
    int toTrue; // monkey number to throw to if true
    int toFalse; // monkey number to throw to if true
    int rounds;

    void print() {
      System.out.printf("Monkey %d\n", num);
      System.out.printf("  Items: %s\n", items.toString());
      if (factor != null) {
        System.out.printf("  Operation: new = old %s %s\n", op, factor.toString());
      } else {
        System.out.printf("  Operation: new = old * old\n");
      }
      System.out.printf("  Test: divible by %s\n", test.toString());
      System.out.printf("    If true: throw to monkey %d\n", toTrue);
      System.out.printf("    If false: throw to monkey %d\n", toFalse);
      System.out.printf("  Rounds: %d\n", rounds);
    }

    void shortPrintMonkey() {
      System.out.printf("Monkey %d\n", num);
      System.out.printf("  Items: %s\n", items.toString());
      System.out.printf("  Rounds: %d\n", rounds);
    }

    static Monkey parseMonkey(int i) {
      if (nextLine >= lines.length) {
        return null;
      }

      if (nextLine() == null) {
        // skip monkey lin enumber
        return null;
      }
      Monkey m = new Monkey();
      m.num = i;
      String items = nextLine();
      items = items.substring(18);
      Iterable<String> parts = Splitter.on(",").split(items);
      for (String item : parts) {
        item = item.trim();
        m.items.add(new BigDecimal(item));
      }
      String operation = nextLine();
      String[] partarray = splitToArray(operation);
      operation = partarray[4];
      if (partarray[5].equals("old")) {
        m.op = Operation.Square;
      } else {
        if (operation.equals("+")) {
          m.op = Operation.Add;
        } else {
          m.op = Operation.Mult;
        }
        m.factor = new BigDecimal(partarray[5]);
      }

      String test = nextLine();
      partarray = splitToArray(test);
      m.test = new BigDecimal(partarray[3]);

      String toTrue = nextLine();
      partarray = splitToArray(toTrue);
      m.toTrue = Integer.parseInt(partarray[5]);

      String ifFalse = nextLine();
      partarray = splitToArray(ifFalse);
      m.toFalse = Integer.parseInt(partarray[5]);
      nextLine(); // blank
      return m;
    }

    private static String[] splitToArray(String input) {
      return Lists.newArrayList(Splitter.on(" ").split(input.trim())).toArray(new String[0]);
    }

    void throwStuff() {
      if (items == null) {
        return;
      }

      while (items.size() > 0) {
        // process item
        BigDecimal headItem = items.remove(0);
        rounds++;

        BigDecimal vi = headItem;
        // print "Processing item " print vi print " from monkey " println m.num
        // 1. inspect: apply the operation
        switch (op) {
          case Add:
            vi = vi.add(factor);
            break;
          case Mult:
            vi = vi.multiply(factor);
            break;
          case Square:
            vi = vi.multiply(vi);
            break;
        }
        vi = vi.remainder(allfact);
        // print "new worry level " println vi

        // 2. divide by 3
        //        vi = vi.divideToIntegralValue(THREE);
        // print "bored worry level " println vi
        // 3. is value divisible by "test"
        BigDecimal rem = vi.remainder(test);
        if (rem.equals(BigDecimal.ZERO)) {
          // 4. if true, add to monkey true's list
          // print "bored worry level divisible by " println m.test
          Monkey m2 = monkeys[toTrue];
          m2.items.add(vi);
        } else {
          // 5. if false, add to monkey false's list
          // print "bored worry level not divisible by " println m.test
          Monkey m2 = monkeys[toFalse];
          m2.items.add(vi);
        }
      }
    }
  }

  static BigDecimal allfact;
  static Monkey[] monkeys = new Monkey[8];
  static int nextLine = 0;
  //  static String lines[] = SMALL.split("\n");
  static String lines[] = BIG.split("\n");

  private static String nextLine() {
    if (nextLine >= lines.length) {
      return null;
    }
    return lines[nextLine++];
  }

  public static void main(String[] args) {
    allfact = BigDecimal.ONE;
    // parse monkeys
    for (int i = 0; ; i++) {
      Monkey m = Monkey.parseMonkey(i);
      if (m == null) {
        break;
      }
      monkeys[i] = m;
      m.print();
      allfact = allfact.multiply(m.test);
    }

    doRounds(10000);

    // ugh finding top 2 best is a pain in the butt
    long[] top = {-1, -1};

    for (int j = 0; j < 8; ++j) {
      Monkey m = monkeys[j];
      if (m != null) {
        m.print();
        if (m.rounds > top[0]) {
          top[0] = m.rounds;
        }
      }
    }
    for (int j = 0; j < 8; ++j) {
      Monkey m = monkeys[j];
      if (m != null) {
        m.print();
        if (m.rounds > top[1] && m.rounds < top[0]) {
          top[1] = m.rounds;
        }
      }
    }

    System.out.printf("Part 1: %d\n", top[0] * top[1]);
  }

  private static void doRounds(int rounds) {
    for (int i = 0; i < rounds; ++i) {
      for (int j = 0; j < 8; ++j) {
        if (monkeys[j] != null) {
          monkeys[j].throwStuff();
        }
      }

      if (i == 19 || (i % 1000) == 0) {
        System.out.printf("After round %s\n", i);
        for (int j = 0; j < 8; ++j) {
          if (monkeys[j] != null) {
            monkeys[j].shortPrintMonkey();
          }
        }
      }
    }
  }
}
