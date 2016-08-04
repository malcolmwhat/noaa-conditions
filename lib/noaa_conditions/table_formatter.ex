defmodule NoaaConditions.TableFormatter do

  @moduledoc """
  Handles printing of relevant NoaaConditions data, in a tabular format.
  """

  def print(values, fields, field_names) do
    import Enum, only: [map: 2, max: 1, each: 2]

    len = &(String.length(&1))
    left_column_length = Map.values(field_names) |> map(len) |> max

    names = update_map(field_names, &(String.rjust(&1, left_column_length)))

    each fields, fn(field) ->
      IO.write names[field] <> " : "
      IO.puts values[to_string(field)]
    end
  end

  def update_map(map, fun), do: _update_map(map, Map.keys(map), fun)
  defp _update_map(map, [ key | rest ], fun) do
    Map.update!(map, key, fun)
    |> _update_map(rest, fun)
  end
  defp _update_map(map, [], _) do
    map
  end
end
