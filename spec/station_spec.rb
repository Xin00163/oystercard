require 'station'
describe Station do
  station = Station.new(name = "Victoria", zone =  "1")

  it 'returns a name' do
    expect( station.name ).to eq "Victoria"
  end
  it 'returns a zone' do
    expect( station.zone ).to eq "1"
  end
end
