defmodule StexTest do
  use ExUnit.Case
  doctest Stex

  test "greets the world" do
    assert Stex.hello() == :world
  end
end
