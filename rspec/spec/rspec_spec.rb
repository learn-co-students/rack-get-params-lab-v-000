require 'spec_helper'

describe Rspec do
  it 'has a version number' do
    expect(Rspec::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
