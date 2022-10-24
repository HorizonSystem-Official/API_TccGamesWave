using API_TccGamesWave.Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace API_TccGamesWave.Banco
{
    public class BdConexao
    {
        public class BdConector
        {
            MySqlConnection conexao;

            public BdConector()
            {
                //cria conexão
                conexao = new MySqlConnection(ConfigurationManager.ConnectionStrings["conexao"].ConnectionString);
                conexao.Open();

            }

            public void FecharBd()
            {
                conexao.Close();
            }


            //Selecet um prod pelo cod
            public List<Produto> SelecionaUmProdSimples(int idProd)
            {

                MySqlCommand cmd = new MySqlCommand("call spMostraProdSimples(@idProd)", conexao);
                cmd.Parameters.AddWithValue("@idProd", idProd);
                MySqlDataReader reader = cmd.ExecuteReader();
                List<Produto> prods = new List<Produto>();
                while (reader.Read())
                {
                    var TempProd = new Produto()
                    {
                        CodProd = int.Parse(reader["codProd"].ToString()),
                        ProdNome = reader["prodNome"].ToString(),
                        ProdTipo = reader["prodTipo"].ToString(),
                        ProdValor = decimal.Parse(reader["prodValor"].ToString()),
                        ImgCapa = reader["imgCapa"].ToString()
                    };

                    prods.Add(TempProd);
                }
                reader.Close();
                return prods;
            }

            //mostra prod por categoria 
            public List<Produto> ProdPorCategoria(string cat)
            {

                MySqlCommand cmd = new MySqlCommand("call spMostraProdCategoria(@cat)", conexao);
                cmd.Parameters.AddWithValue("@cat", cat);
                MySqlDataReader reader = cmd.ExecuteReader();
                List<Produto> prods = new List<Produto>();
                while (reader.Read())
                {
                    var TempProd = new Produto()
                    {
                        CodProd = int.Parse(reader["codProd"].ToString()),
                        ProdNome = reader["prodNome"].ToString(),
                        ProdTipo = reader["prodTipo"].ToString(),
                        ProdValor = decimal.Parse(reader["prodValor"].ToString()),
                        ImgCapa = reader["imgCapa"].ToString()
                    };

                    prods.Add(TempProd);
                }
                reader.Close();
                return prods;
            }

            public List<Cliente> DadosCliente (string idCli)
            {

                MySqlCommand cmd = new MySqlCommand("call spDadosCliente(@idCli)", conexao);
                cmd.Parameters.AddWithValue("@idCli", idCli);
                MySqlDataReader reader = cmd.ExecuteReader();
                List<Cliente> Cli = new List<Cliente>();
                while (reader.Read())
                {
                    var TempCli = new Cliente()
                    {
                        CPF = reader["CPF"].ToString(),
                        NomeCliente = reader["NomeCliente"].ToString(),
                        DataNasc = DateTime.Parse(reader["DataNasc"].ToString()),
                        Senha = reader["Senha"].ToString(),
                        EmailCli = reader["EmailCli"].ToString(),
                        CepCli = reader["CepCli"].ToString(),
                        NumEndCli = reader["NumEndCli"].ToString(),
                        TelCli = reader["TelCli"].ToString()
                    };

                    Cli.Add(TempCli);
                }
                reader.Close();
                return Cli;
            }
        }
    }
}