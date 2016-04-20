require "mergelist/version"

module Mergelist
  # Ye olde min- heap using array as a backing store.
  # Note that the only nasty part is that array indexing starts at 1 vs 0.
  # the reason for that is of course due to definition of parent, left & right.
  # left(0) == 0
  class MinHeap

    attr_reader :size

    def initialize()
      @list = []
      @size = 0
    end

    # heap invariant.
    def valid?
      (2..size).all? { |i| elem(i) > elem(parent(i)) }
    end

    # insert value into heap. O(lg @size)
    def insert(val)
      @list[@size] = val
      @size += 1
      i = @size

      # Increase heap size, add a leaf.
      # Now float the leaf up the tree.
      while i > 1 && elem(parent(i)) > elem(i)
        swap(parent(i), i)
        i = parent(i)
      end
    end

    def min
      elem(1)
    end

    # Extracts min O(lg @size)
    def extract_min
      val = elem(1)
      swap(1, @size)
      @size -= 1
      min_heapify(1)
      val
    end

    private 

    # parent <= left(parent) && parent <= right(parent)
    def min_heapify(idx)
      l = left(idx)
      r = right(idx)
      smaller = idx
      smaller = l if l <= @size && elem(l) < elem(idx)
      smaller = r if r <= @size && elem(r) < elem(smaller)
      swap(smaller, idx) if smaller != idx
      min_heapify(smaller) if smaller != idx
    end


    def parent(idx)
      return 1 if idx == 1
      (idx / 2).floor
    end

    def left(idx)
      idx * 2
    end

    def right(idx)
      idx * 2 + 1
    end

    def elem(idx)
      @list[idx-1]
    end

    def swap(fst, snd) 
      @list[fst-1], @list[snd-1] = @list[snd-1], @list[fst-1]
    end
  end
end
