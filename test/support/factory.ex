defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "address" => "Rua das banananeiras 15",
      "age" => 27,
      "cep" => "12345678",
      "cpf" => "12345678901",
      "email" => "rafael@banana.com",
      "name" => "Rafael Camarda",
      "password" => "123456"
    }
  end

  def user_factory do
    %User{
      address: "Rua das banananeiras 15",
      age: 27,
      cep: "12345678",
      cpf: "12345678901",
      email: "rafael@banana.com",
      name: "Rafael Camarda",
      id: "e0cb8256-1eb5-4cc5-8549-4a61671b3d18",
      password: "123456"
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
