defmodule TrialTest do
  use ExUnit.Case
  doctest Trial

  test "greets the world" do
    assert Trial.hello() == :world
  end
end
