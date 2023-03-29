-- Criar usuário
CREATE USER 'Rodrigo'@'localhost' IDENTIFIED BY 'senha';

-- Garantir todas as permissões
GRANT ALL PRIVILEGES ON dimensional TO 'Rodrigo'@'localhost' WITH GRANT OPTION;