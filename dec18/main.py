def aoc18():
    L = [complex(*map(int, line.split(","))) for line in open("input.txt")]

    def flee(k):
        M = {complex(a,b):0 for a in range(71) for b in range(71)}
        nextset = {step:=0}
        while nextset:
            nextset, curset = set(), nextset
            for c in curset:
                for v in [c+d for d in [1,-1,1j,-1j] if not M.get(c+d,-1) and c+d not in L[:k]]:
                    M[v] = step+1
                    nextset.add(v)
            step += 1
        return M[complex(70,70)]

    #part 1
    print(flee(1024))

    # part 2, bisect until we find when the threshold is
    low, high = 0, len(L)
    while low < high:
        mid = (low+high) // 2
        if flee(mid) == 0:
            high = mid - 1
        else:
            low = mid + 1
    print(L[mid+1])

aoc18()
