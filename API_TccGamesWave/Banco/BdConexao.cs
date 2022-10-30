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

            //mostra prod detalhado
            public List<Produto> ProdDetalhado(int idProd)
            {

                MySqlCommand cmd = new MySqlCommand("call spMostraProdDetalhado(@idProd)", conexao);
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
                        ProdDesc = reader["prodDesc"].ToString(),
                        ProdAnoLanc = reader["prodAnoLanc"].ToString(),
                        ProdFaixaEtaria = reader["prodFaixaEtaria"].ToString(),
                        ProdValor = decimal.Parse(reader["prodValor"].ToString()),
                        ImgCapa = reader["imgCapa"].ToString()
                    };

                    prods.Add(TempProd);
                }
                reader.Close();
                return prods;
            }

            //Selecet um prod pelo cod
            public List<Comentarios> MostraComentariosProd(int idProd)
            {

                MySqlCommand cmd = new MySqlCommand("call spMostraComentarios(@idProd)", conexao);
                cmd.Parameters.AddWithValue("@idProd", idProd);
                MySqlDataReader reader = cmd.ExecuteReader();
                List<Comentarios> comentario = new List<Comentarios>();
                while (reader.Read())
                {
                    var TempComent = new Comentarios()
                    {
                        TxtComentario = reader["txtComentario"].ToString(),
                        NomeCliente = reader["nomeCliente"].ToString()
                    };

                    comentario.Add(TempComent);
                }
                reader.Close();
                return comentario;
            }

            public List<Cliente> DadosCliente (string CpfCli)
            {

                MySqlCommand cmd = new MySqlCommand("call spDadosCliente(@CpfCli)", conexao);
                cmd.Parameters.AddWithValue("@CpfCli", CpfCli);
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