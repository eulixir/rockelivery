defmodule RockeliveryWeb.UsersViewWeb do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)
    token = "b4nANa123"

    response = render(UsersView, "create.json", user: user, token: token)

    assert %{
             message: "User created",
             token: "b4nANa123",
             user: %{
               user: %Rockelivery.User{
                 address: "Rua das bananeiras, 15",
                 age: 27,
                 cep: "12345678",
                 cpf: "12345678900",
                 email: "jp@banana.com",
                 id: "69961117-d966-4e2f-ac55-476d4f78ddfa",
                 inserted_at: nil,
                 name: "Jp",
                 password: "123456",
                }
             }
           } == response
  end
end
