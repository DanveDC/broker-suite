CREATE TABLE comisiones_config (
    id INT AUTO_INCREMENT PRIMARY KEY,
    compania VARCHAR(255) NOT NULL,
    ramo VARCHAR(255) NOT NULL,
    subramo VARCHAR(255),
    producto VARCHAR(255) NOT NULL,
    tipo_ejecutivo VARCHAR(255) NOT NULL,
    porcentajes VARCHAR(255) NOT NULL
);
