defmodule LambdaExTest do
  use ExUnit.Case
  doctest LambdaEx

  test "greets the world" do
    assert LambdaEx.hello() == :world
  end
end
