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
  end
end
