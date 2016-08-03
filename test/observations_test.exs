defmodule ObservationsTest do
  use ExUnit.Case

  doctest NoaaConditions.Observations

  import NoaaConditions.Observations

  test "URL forms correctly" do
    assert obs_url("KBXK") == "http://w1.weather.gov/xml/current_obs/KBXK.xml"
  end

  test "Valid location_code fetches correctly" do
    assert { :ok, _ } = fetch("KBXK")
  end

  test "Valid location has valid fields populated" do
    import SweetXml
    assert { :ok, xml } = fetch("KGXF")

    loc = 'Gila Bend Air Force Auxiliary Field, AZ'

    result = xml |> xpath(~x"//current_observation/location/text()")
    assert loc == result
  end
end
