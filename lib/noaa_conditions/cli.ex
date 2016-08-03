defmodule NoaaConditions.CLI do

  @moduledoc """
  Handle command line parsing and calling of other functions that generate
  a tabular representation of the weather data.
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ],
                                     aliases:  [ h:    :help    ])

    case parse do
      { [ help: true ], _, _ }
        -> :help
      { _, [ location_code ], _ }
        -> location_code

      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage:   noaa_conditions <location_code>
    """
    System.halt(0)
  end
  def process(location_code) do
    
  end
end
