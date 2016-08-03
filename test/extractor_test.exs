defmodule ExtractorTest do
  use ExUnit.Case
  doctest NoaaConditions.Extractor

  test "Extractor works correctly for a single field" do
    assert { :ok, xml } = NoaaConditions.Observations.fetch("KDMA")

    assert '32.16667' == NoaaConditions.Extractor.get(xml, "latitude")
  end

  test "Extractor works correctly for multiple fields" do
    assert { :ok, xml } = NoaaConditions.Observations.fetch("KDMA")

    vals = ['32.16667', '-110.88333', 'Davis-Monthan Air Force Base, AZ']
    fields = ["latitude", "longitude", "location"]

    assert vals == NoaaConditions.Extractor.get(xml, fields)
  end

  test "Extractor returns maps correctly" do
    assert { :ok, xml } = NoaaConditions.Observations.fetch("KDMA")

    vals = ['32.16667', '-110.88333', 'Davis-Monthan Air Force Base, AZ']
    fields = ["latitude", "longitude", "location"]
    test_map = Enum.zip(fields, vals) |> Map.new

    assert test_map == NoaaConditions.Extractor.get_map(xml, fields)
  end
end
