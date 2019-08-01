# Processo Seletivo Itaú

## Autores

  * Fábio França Costa Júnior: [Linkedin](https://www.linkedin.com/in/fabiofrancajr),[GitHub](https://github.com/fabiofranca19)
  * Paulo Ricardo de Araujo Vieira: [Linkedin](https://www.linkedin.com/in/pauloricardoav),[GitHub](https://github.com/pauloricardo56)

## Raciocínio

Basicamente queriamos fazer uma simulação de transferências entre contas bancárias. O cliente deve fazer seu login e depois selecionar a sua conta bancária que pode variar entre uma conta corrente ou uma conta poupança, em seguida, deve selecionar o contato para quem o cliente deseja fazer a transferência. Após isso, veremos a tela de confirmação de valores e de contas envolvidas.

## Lógica

Criamos um arquivo JSON (API), que possui todos os dados relacionados aos clientes e suas contas (poupança e corrente), dela consumimos os dados e inserimos (parse) em UITableView's para a apresentação dos mesmos. Apos o usuário fazer o login, checamos dentro dos dados recuperados qual(is) será(ão) sua(s) conta(s) e seu(s) contato(s). Deve-se selecionar pelo menos uma conta e um contato para habilitar a transferência. Na tela de confirmação, verificamos se o valor informado é valido, ou seja, não pode passar do saldo da conta origem ou não pode ultrapassar o valor de 10.000. Após a confirmação, criamos um outro arquivo JSON para fazer a substituição do atual, esse arquivo é armazenado localmente.

## Detalhes da solução

  * Caso o contato tenha os dois tipos de conta (corrente e poupança), o nosso sistema prioriza a conta corrente para fazer a transferência entre a conta origem (cliente) e a conta destino (contato).
  * Lembramos que isso é apenas uma simulação, tendo em conta que nós nunca tivemos contato com nenhuma aplicação bancaria, ou seja, tentamos implementar uma soluçao que nós vimos como a melhor forma.

## Tecnologias usadas

  * Swift
  * UIKIT
  * JSON (Cloud Service)
  * UITableView
  * UIPickerView
  * Auto Layout
  * StackView
  * Delegate (design patterns)
  * FileManager
  * POO
  * UIAlertController
  * Closure
  * Storyboards
  * Git

  
   
