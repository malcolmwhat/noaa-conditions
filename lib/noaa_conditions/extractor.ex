defmodule NoaaConditions.Extractor do

  @moduledoc """
  Specialized and specific extractions of fields from XML.
  """
  def get_map(xml, [ field | rest ]) do
    []
  end

  def get(xml, [ field | rest ]), do: [ get(xml, field) | get(xml, rest) ]
  def get(_, []), do: []

  def get(xml, field) do
    import SweetXml
    xml
    |> xpath(~x"//current_observation/#{field}/text()")
  end
end
