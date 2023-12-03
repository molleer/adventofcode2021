import java.io.File
import java.util.PriorityQueue

fun next_step(map: List<String>, pos: Pair<Int, Int>): List<Pair<Pair<Int, Int>, Int>> {
    return listOf(
                    Pair(pos.first, pos.second + 1),
                    Pair(pos.first + 1, pos.second),
                    Pair(pos.first - 1, pos.second),
                    Pair(pos.first, pos.second - 1)
            )
            .filter {
                it.first >= 0 &&
                        it.second >= 0 &&
                        it.first < map[pos.first].length &&
                        it.second < map.size
            }
            .map { Pair(it, map[it.second].get(it.first).code - '0'.code) }
}

fun backtrack(lines: List<String>, best_risk: HashMap<Pair<Int, Int>, Int>, pos: Pair<Int, Int>) {
    var goal = Pair(0, 0)
    var next = pos
    while (true) {
        print("$next -> ")
        println(lines[next.second].get(next.first))
        if (next.equals(goal)) {
            break
        }
        var nexts =
                listOf(
                        Pair(next.first, next.second + 1),
                        Pair(next.first + 1, next.second),
                        Pair(next.first - 1, next.second),
                        Pair(next.first, next.second - 1)
                )
        next = nexts.minBy { best_risk.getOrDefault(it, Int.MAX_VALUE) }
    }
}

fun expand_line(line: String): String {
    var new_line = ""
    for (c in line) {
        new_line += (c.code - '0'.code) % 9 + 1
    }
    return new_line
}

fun expand(lines: List<String>): List<String> {
    var new_lines = ArrayList<String>()

    for (line in lines) {
        var new_line = line
        var expanded_line = expand_line(line)
        for (i in 0..3) {
            new_line += expanded_line
            expanded_line = expand_line(expanded_line)
        }
        new_lines.add(new_line)
    }

    for (i in lines.size ..< lines.size * 5) {
        new_lines.add(expand_line(new_lines[i - lines.size]))
    }

    return new_lines
}

fun main() {
    var lines = File("input.txt").readLines()
    lines = expand(lines)
    var goal = Pair(lines[0].length - 1, lines.size - 1)
    var queue =
            PriorityQueue<Pair<Pair<Int, Int>, Int>> {
                    p1: Pair<Pair<Int, Int>, Int>,
                    p2: Pair<Pair<Int, Int>, Int> ->
                p1.second.compareTo(p2.second)
            }
    queue.add(Pair(Pair(0, 0), 0))
    var best_risk = HashMap<Pair<Int, Int>, Int>()

    while (true) {
        var pos = queue.poll()
        while (pos.first in best_risk) {
            pos = queue.poll()
        }

        if (pos.first.equals(goal)) {
            println(pos.second)
            break
        }
        best_risk.set(pos.first, pos.second)
        queue.addAll(
                next_step(lines, pos.first).filter { !(it.first in best_risk.keys) }.map {
                    Pair(it.first, it.second + pos.second)
                }
        )
    }
    // backtrack(lines, best_risk, goal)
}
