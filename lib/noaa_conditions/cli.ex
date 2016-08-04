defmodule NoaaConditions.CLI do

  @moduledoc """
  Handle command line parsing and calling of other functions that generate
  a tabular representation of the weather data.
  """

  @default_fields [
    :location, :station_id, :latitude, :longitude, :observation_time,
    :observation_time_rfc822, :weather, :temperature_string, :dewpoint_string,
    :relative_humidity, :wind_string, :visibility_mi, :pressure_string,
    :pressure_in
  ]

  @field_names %{
    location: "Location", station_id: "Station ID", latitude: "Lat (N)",
    longitude: "Long (W)", observation_time: "Time",
    observation_time_rfc822: "Obs Time rfc822", weather: "Weather",
    temperature_string: "Temp", dewpoint_string: "Dewpoint",
    relative_humidity: "Relative Humidity (%)", wind_string: "Wind",
    visibility_mi: "Visibility (mi)", pressure_string: "MSL Pressure",
    pressure_in: "Altimeter"
  }

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
    fields = Enum.map(@default_fields, &(to_string(&1)))
    NoaaConditions.Observations.fetch(location_code)
    |> validate
    |> NoaaConditions.Extractor.get_map(fields)
    |> NoaaConditions.TableFormatter.print(@default_fields, @field_names)
  end

  def validate({ :ok, xml }), do: xml
  def validate({ :error, code }), do: raise "#{code} error on request"

end
