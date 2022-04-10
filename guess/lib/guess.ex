defmodule Guess do
  @moduledoc """
  Documentation for `Guess`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Guess.hello()
      :there

  """
  use Application

  def start(_, _) do
    run()
    {:ok, self()}
  end

  def parse_args(:error) do
    IO.warn("Invalid arguments")
    run()
  end

  # def parse_args(data) do
  #   if data == :error do
  #     IO.puts("Error: invalid arguments")
  #     run()
  #   else
  #     {num, _} = data
  #     num
  #   end
  # end

  def parse_args({num, _}) do
    num
  end

  def parse_args(data) do
    data
    |> Integer.parse()
    |> parse_args()
  end

  def get_range(level) do
    case level do
      1 ->
        1..10

      2 ->
        1..30

      3 ->
        1..100

      _ ->
        IO.warn("Invalid level")
        run()
    end
  end

  def pick_num(level) do
    level
    |> get_range()
    |> Enum.random()
  end

  def getlevel do
    IO.gets("Get a level: [1: easy, 2: medium, 3: hard]: ")
    |> parse_args()
    |> pick_num()
    |> play()
    |> IO.inspect()
  end

  def play(num) do
    IO.gets("Pick a number: ")
    |> parse_args()
    |> guess(num, 1)
  end

  def get_score(count) do
    {_, msg} =
      %{
        (1..1) => "Man you are good",
        (2..4) => "impresive",
        (5..10) => "you can do better",
        (11..15) => "i've seen mules better than you",
        (15..100) => "ohh, i thinked we never will finish"
      }
      |> Enum.find(fn {range, _} ->
        Enum.member?(range, count)
      end)

    IO.puts(msg)
  end

  def guess(user_guess, num, count) when user_guess > num do
    IO.gets("Too high, Try again: ")
    |> parse_args()
    |> guess(num, count + 1)
  end

  def guess(user_guess, num, count) when user_guess < num do
    IO.gets("Too Low, Try again: ")
    |> parse_args()
    |> guess(num, count + 1)
  end

  def guess(_user_guess, _num, count) do
    IO.puts("#{count}x, Correct !!!")
    get_score(count)
  end

  def run() do
    IO.puts("Let's play a game: Guess the number!")
    getlevel()
  end

  def hello do
    :there
  end
end
