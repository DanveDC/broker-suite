# BrokerCore — Resumen Ejecutivo

## El problema

Las corredoras de seguros venezolanas suelen gestionar su operación de forma manual y dispersa: asegurados en una planilla, pólizas en otra, comisiones de cada aseguradora en archivos sueltos, y cobranza reconstruida a mano al cierre de cada mes. Esto genera errores, duplica trabajo y hace casi imposible tener una vista consolidada del negocio en tiempo real.

## Qué es BrokerCore

Un sistema de gestión integral, web, para corredoras de seguros, que centraliza toda la operación en una única plataforma accesible desde cualquier navegador.

## Para quién es

Corredoras de seguros venezolanas que necesitan centralizar su operación diaria, gestionar comisiones de múltiples aseguradoras y generar reportes internos y regulatorios (Sudaseg) sin depender de planillas dispersas.

## Módulos principales

* **Asegurados** — registro y búsqueda de personas aseguradas por cédula de identidad.
* **Pólizas** — ciclo completo (Persona/HCM, Auto, Patrimonial, Viaje, Fianza): alta, renovación, pagos y anulación.
* **Siniestros** — Carta Aval, Reembolso médico y Siniestro de Auto, con seguimiento por notas.
* **Gestión de Producto** — catálogo administrable de Compañía → Ramo → Subramo → Producto, con altas/bajas controladas por rol, usado por el formulario de pólizas.
* **Comisiones** — registro de comisiones recibidas de las aseguradoras y reportes por ejecutivo.
* **Cobranza** — seguimiento de cobros de primas y proyección anual.
* **Reportes** — dashboard de negocio y reporte regulatorio Sudaseg.

## Stack tecnológico actual

Flask (Python) + MySQL/TiDB Cloud vía PyMySQL, sin ORM, con Jinja2 + Sneat Bootstrap 5 para la interfaz.

## Estado de despliegue

En producción en **Render.com**, con **Docker** disponible como alternativa de despliegue portable (mismo código, cualquier proveedor con soporte de contenedores).

## Estado actual

* El camino completo — alta de asegurado, póliza, cobro, comisión y reportes — funciona de punta a punta hoy en producción.
* La arquitectura es simple y directa a propósito: un monolito Flask sin capas de abstracción innecesarias, fácil de razonar para el equipo actual.
* El sistema está activo y en uso, con una base de datos real en TiDB Cloud y despliegue reproducible tanto en Render como en Docker.
* Interfaz modernizada: sistema de diseño consistente (tokens de color/tipografía/sombras), accesibilidad WCAG 2.1 AA (contraste, navegación por teclado, lectores de pantalla) y microinteracciones (estados de carga, transiciones, feedback táctil) en todos los módulos.
* Endurecido para producción: auditoría integral de rutas y plantillas, con corrección de errores de compatibilidad entre entornos de desarrollo y despliegue.

