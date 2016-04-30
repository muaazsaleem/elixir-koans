defmodule PatternMatching do
  use Koans

  koan "One matches one" do
    assert match?(1, 1)
  end

  koan "A pattern can change" do
    a = 1
    a = 2
    assert a == 2
  end

  koan "A pattern can also be strict" do
    a = 1
    assert_raise MatchError, fn() ->
      ^a = 2
    end
  end

  koan "Patterns can be used to pull things apart" do
    [head | tail] = [1, 2, 3, 4]

    assert head == 1
    assert tail == [2, 3, 4]
  end

  koan "And then put them back together" do
    head = 1
    tail = [2, 3, 4]

    assert [1, 2, 3, 4] == [head | tail]
  end

  koan "Some values can be ignored" do
    [_first, _second, third, _fourth] = [1, 2, 3, 4]

    assert third == 3
  end

  koan "Strings come apart just as easily" do
    "Shopping list: " <> items = "Shopping list: eggs, milk"

    assert items == "eggs, milk"
  end

  koan "Patterns show what you really care about" do
    %{make: make} = %{type: "car", year: 2016, make: "Honda", color: "black"}

    assert make == "Honda"
  end

  koan "The pattern can make assertions about what it expects" do
    assert match?([1, _second, _third], [1, 2, 3])
  end

  def make_noise(%{type: "cat"}), do: "Meow"
  def make_noise(%{type: "dog"}), do: "Woof"
  def make_noise(_anything), do: "Eh?"

  koan "Functions can declare what kind of arguments they accept" do
    cat = %{type: "cat"}
    dog = %{type: "dog"}
    snake = %{type: "snake"}

    assert make_noise(cat) == "Meow"
    assert make_noise(dog) == "Woof"
    assert make_noise(snake) == "Eh?"
  end

  koan "And they will only run the code that matches the argument" do
    name = fn
      ("duck")  -> "Donald"
      ("mouse") -> "Mickey"
      (_other)  -> "I need a name!"
    end

    assert name.("mouse") == "Mickey"
    assert name.("duck") == "Donald"
    assert name.("donkey") == "I need a name!"
  end

  koan "Errors are shaped differently than successful results" do
    dog = %{type: "dog"}

    result = case Map.fetch(dog, :type) do
      {:ok, value} -> value
      :error -> "not present"
    end

    assert result == "dog"
  end

  defmodule Animal do
    defstruct [:kind, :name]
  end

  koan "You can pattern match into the fields of a struct" do
    %Animal{name: name} = %Animal{kind: "dog", name: "Max"}
    assert name == "Max"
  end
end
