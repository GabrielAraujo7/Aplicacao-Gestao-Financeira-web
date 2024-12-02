defmodule ProjectDelta.Finance do
  import Ecto.Query, warn: false
  alias ProjectDelta.Repo

  alias ProjectDelta.Finance.Receita
  alias ProjectDelta.Finance.Despesa

  # Função que aplica todos os filtros
  defp aplicar_filtros(query, params) do
    # Extraindo os parâmetros dos filtros
    mes = Map.get(params, "mes", nil) |> tratar_valor_vazio()
    periodo = Map.get(params, "periodo", nil) |> tratar_valor_vazio()
    ordenacao = Map.get(params, "ordenacao", nil) |> tratar_valor_vazio()

    # Log para inspecionar os parâmetros recebidos
    IO.inspect({"Mes", mes, "Período", periodo, "Ordenação", ordenacao}, label: "Parametros de Filtro")

    # Aplicando os filtros na query
    query
    |> filtro_por_mes(mes)
    |> filtro_por_periodo(periodo)
    |> filtro_por_ordenacao(ordenacao)
  end

  # Função para tratar valores vazios
  defp tratar_valor_vazio(""), do: nil
  defp tratar_valor_vazio(valor), do: valor

  # Filtro por mês
  defp filtro_por_mes(query, nil), do: query  # Não aplica filtro se "mes" for nil
  defp filtro_por_mes(query, mes) do
    case Integer.parse(mes) do
      {mes_int, _} when mes_int in 1..12 ->  # Verifica se é um mês válido (1-12)
        from r in query, where: fragment("EXTRACT(MONTH FROM ?) = ?", r.data, ^mes_int)
      _error ->
        query  # Retorna a query original se o mês for inválido
    end
  end

  # Filtro por período
  defp filtro_por_periodo(query, nil), do: query  # Não aplica filtro se "periodo" for nil
  defp filtro_por_periodo(query, periodo) do
    # Ajuste para o formato "MM/YYYY a MM/YYYY"
    [start_date, end_date] = String.split(periodo, " a ")

    # Convertendo para o formato "YYYY-MM-01" (adicionando o dia 01 ao mês/ano)
    start_date = format_period(start_date)
    end_date = format_period(end_date)

    # Tentando converter as datas para o formato Date
    case {Date.from_iso8601(start_date), Date.from_iso8601(end_date)} do
      {{:ok, start_date}, {:ok, end_date}} ->
        # Aplica o filtro com base nas datas convertidas
        from r in query, where: r.data >= ^start_date and r.data <= ^end_date
      _error ->
        query  # Se houver erro, retorna a query sem alteração
    end
  end

  # Função para formatar o período para o formato "YYYY-MM-01"
  defp format_period(period) do
    [month, year] = String.split(period, "/")
    year <> "-" <> month <> "-01"  # Concatena para o formato "YYYY-MM-01"
  end

  # Filtro por ordenação
  defp filtro_por_ordenacao(query, nil), do: query  # Não aplica ordenação se "ordenacao" for nil
  defp filtro_por_ordenacao(query, "maiores") do
    # Ordena de forma decrescente para mostrar os maiores
    from r in query, order_by: [desc: r.valor]
  end

  defp filtro_por_ordenacao(query, "menores") do
    # Ordena de forma crescente para mostrar os menores
    from r in query, order_by: [asc: r.valor]
  end

  # Função para listar as receitas com filtros aplicados
  def list_receitas_with_filters(params) do
    Receita
    |> aplicar_filtros(params)  # Aplica os filtros passados em `params`
    |> Repo.all()
  end

  # Função para listar as despesas com filtros aplicados
  def list_despesas_with_filters(params) do
    Despesa
    |> aplicar_filtros(params)  # Aplica os filtros passados em `params`
    |> Repo.all()
  end

  # Funções CRUD para receitas
  def list_receitas do
    Repo.all(Receita)
  end

  def get_receita!(id), do: Repo.get!(Receita, id)

  def create_receita(attrs \\ %{}) do
    %Receita{}
    |> Receita.changeset(attrs)
    |> Repo.insert()
  end

  def update_receita(%Receita{} = receita, attrs) do
    receita
    |> Receita.changeset(attrs)
    |> Repo.update()
  end

  def delete_receita(%Receita{} = receita) do
    Repo.delete(receita)
  end

  def change_receita(%Receita{} = receita, attrs \\ %{}) do
    Receita.changeset(receita, attrs)
  end

  # Funções CRUD para despesas
  def list_despesas do
    Repo.all(Despesa)
  end

  def get_despesa!(id), do: Repo.get!(Despesa, id)

  def create_despesa(attrs \\ %{}) do
    %Despesa{}
    |> Despesa.changeset(attrs)
    |> Repo.insert()
  end

  def update_despesa(%Despesa{} = despesa, attrs) do
    despesa
    |> Despesa.changeset(attrs)
    |> Repo.update()
  end

  def delete_despesa(%Despesa{} = despesa) do
    Repo.delete(despesa)
  end

  def change_despesa(%Despesa{} = despesa, attrs \\ %{}) do
    Despesa.changeset(despesa, attrs)
  end
end
