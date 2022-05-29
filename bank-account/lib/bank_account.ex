defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  use GenServer, restart: :transient, shutdown: 10_000

  @doc """
  Open the bank. Makes the account available.
  """

  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = start_link()
    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: :ok
  def close_bank(account) do
    GenServer.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    if Process.alive?(account) do
      GenServer.call(account, :get_balance)
    else
      {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    if Process.alive?(account) do
      GenServer.cast(account, {:update, amount})
    else
      {:error, :account_closed}
    end
  end

  @spec start_link :: :ignore | {:error, any} | {:ok, pid}
  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  @spec init(:ok) :: {:ok, %{balance: 0}}
  def init(:ok) do
    {:ok, %{balance: 0}}
  end

  def handle_call(:get_balance, _from, state) do
    {:reply, Map.get(state, :balance), state}
  end

  def handle_cast({:update, amount}, state) do
    {:noreply, get_updated_balance(state, amount, &(&1 + &2))}
  end

  defp get_updated_balance(state, amount, process_balance) do
    {_, updated_balance} =
      state
      |> Map.get_and_update(:balance, &{&1, process_balance.(&1, amount)})

    updated_balance
  end
end
