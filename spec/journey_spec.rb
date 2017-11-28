require 'journey'

describe Journey do
  it "remembers the entry station" do
    expect(subject.entry_station).to eq "Victoria Station"
  end
end
