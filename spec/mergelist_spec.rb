require 'spec_helper'
require 'mergelist'
require 'rspec/expectations'
require 'rspec/its'

RSpec::Matchers.define :be_a_min_heap do
  match do |heap|
    heap.valid?
  end
end

module  Mergelist
  describe MinHeap do
    let(:heap) { MinHeap.new }
    before { arr.each { |i| heap.insert(i) } }

    let(:arr) { Array(1..32).shuffle }
    subject { heap }
    it { is_expected.to be_a_min_heap }
    its(:min) { is_expected.to be 1 }

    context 'after extraction' do
      before { heap.extract_min }
      its(:min) { is_expected.to be 2 }
      it { is_expected.to be_a_min_heap }
      its(:size) { is_expected.to be arr.size-1 }

      context 'after another extraction' do
        before { heap.extract_min }
        its(:min) { is_expected.to be 3 }
        it { is_expected.to be_a_min_heap }
      end
    end

    context 'with pairs' do
      let(:arr) { Array(1..32).shuffle.map { |x| Pair.new(x, -x) } }
      it { is_expected.to be_a_min_heap }
      its('min.fst') { is_expected.to be 1 }
    end
  end

  describe Merger do 
    context 'merges two lists of different lengths' do
      let(:l1)  { [1,2,4,5,7,8] }
      let(:l2)  { [3,6,9, 10] }
      let(:expected) { (1..10) }
      subject { Merger.mergelists([l1,l2]) }
      it { is_expected.to match_array(expected) }
    end

    context 'merges many lists, with many elements' do 
      let(:nr_lists) { 50 }
      let(:elem_per_list) { 50 }
      let(:lists) {
        lists = Array.new(nr_lists).map { |l| [] }
        (1..nr_lists*elem_per_list).map { |x| lists[x % nr_lists] << x }
        lists
      }
      let(:expected) { (1..nr_lists*elem_per_list) }
      subject { Merger.mergelists(lists) }
      it { is_expected.to match_array(expected) }
    end
  end
end
