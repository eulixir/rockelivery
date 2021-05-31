defmodule Rockelivery do
  alias Rockelivery.Items.Create, as: ItemCreate

  alias Rockelivery.Orders.Create, as: OrderCreate

  alias Rockelivery.Users.Create, as: UserCreate
  alias Rockelivery.Users.Delete, as: UserDelete
  alias Rockelivery.Users.Get, as: UserGet
  alias Rockelivery.Users.Update, as: UserUpdate

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate update_user(params), to: UserUpdate, as: :call

  defdelegate create_item(params), to: ItemCreate, as: :call
  defdelegate create_order(params), to: OrderCreate, as: :call
end

# params = %{
#   address: "Rua das bananeiras",
#   age: 27,
#   cep: "73030038",
#   cpf: "12345678901",
#   email: "Joao@banana",
#   name: "jp",
#   password: "12345678900"
#  }
