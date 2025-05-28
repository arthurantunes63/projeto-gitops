from http import HTTPStatus

from fastapi.testclient import TestClient

from app.main import app

def test_root_deve_retornar_ok_e_ola_mundo():
    # Uma boa estrutura para um teste unitário - 3A
    # 3A: Arrange, Act, Assert

    # Preparando o ambiente para teste - Arrange
    # Criação de client para testes
    client = TestClient(app)

    # Realização da etapa principal do teste - Act
    # Método GET na raiz
    response = client.get('/')  

    # Verificar se tudo ocorreu como esperado - Assert
    # Status HTTP igual a okay e retorno da mensagem correta
    assert response.status_code == HTTPStatus.OK  
    assert response.json() == {"message": "Olá Mundo - CI/CD + FastAPI"}