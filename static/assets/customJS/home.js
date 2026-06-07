const loaderOut = document.querySelector("#loader-out");
function fadeOut(element) {
  let opacity = 1;
  const timer = setInterval(function () {
    if (opacity <= 0.1) {
      clearInterval(timer);
      element.style.display = "none";
    }
    element.style.opacity = opacity;
    opacity -= opacity * 0.1;
  }, 50);
}
fadeOut(loaderOut);

function eliminarEmpleado(id_empleado, foto_empleado) {
  if (confirm("¿Estas seguro que deseas Eliminar el empleado?")) {
    let url = `/borrar-empleado/${id_empleado}/${foto_empleado}`;
    if (url) {
      window.location.href = url;
    }
  }
}

function eliminarPoliza(cod_poliza) {
  if (confirm("¿Estas seguro que deseas Eliminar la poliza?")) {
    let url = `/borrar-poliza/${cod_poliza}`;
    if (url) {
      window.location.href = url;
    }
  }
}

function eliminarAsegurado(CI) {
  if (confirm("¿Estas seguro que deseas Eliminar el asegurado?")) {
    let url = `/borrar-asegurado/${CI}`;
    if (url) {
      window.location.href = url;
    }
  }
}

function eliminarPago(cod_poliza) {
  if (confirm("¿Estas seguro que deseas Eliminar el pago?")) {
    let url = `/borrar-pago/${cod_poliza}`;
    if (url) {
      window.location.href = url;
    }
  }
}

function eliminarEjecutivo(CI) {
  if (confirm("¿Estas seguro que deseas Eliminar el ejecutivo?")) {
    let url = `/borrar-ejecutivo/${CI}`;
    if (url) {
      window.location.href = url;
    }
  }
}

function eliminarCompania(CI) {
  if (confirm("¿Estas seguro que deseas Eliminar la compañia?")) {
    let url = `/borrar-compania/${CI}`;
    if (url) {
      window.location.href = url;
    }
  }
}
