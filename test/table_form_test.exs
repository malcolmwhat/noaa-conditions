defmodule TableFormTest do
  use ExUnit.Case
  alias NoaaConditions.TableFormatter, as: TF
  doctest NoaaConditions.TableFormatter

  test "Update map works correctly" do
    map = %{hello: "meow", test: "wowie!"}
    fun = &(String.length(&1))
    res = %{hello: 4, test: 6}
    assert res == TF.update_map(map, fun)
  end
end
