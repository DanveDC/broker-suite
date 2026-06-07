async function buscadorTable(tableId) {
  let input, busqueda, url;
  url = "/buscando-empleado";

  input = document.getElementById("search");
  busqueda = input.value.toUpperCase();

  const dataPeticion = { busqueda };
  const headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
  };

  try {
    const response = await axios.post(url, dataPeticion, { headers });
    if (!response.status) {
      console.log(`HTTP error! status: ${response.status} 😭`);
    }

    if (response.data.fin === 0) {
      $(`#${tableId} tbody`).html("");
      $(`#${tableId} tbody`).html(`
      <tr>
        <td colspan="6" style="text-align:center;color: red;font-weight: bold;">No resultados para la busqueda: <strong style="text-align:center;color: #222;">${busqueda}</strong></td>
      </tr>`);
      return false;
    }

    if (response.data) {
      $(`#${tableId} tbody`).html("");
      let miData = response.data;
      $(`#${tableId} tbody`).append(miData);
    }
  } catch (error) {
    console.error(error);
  }
}

async function buscadorTableP(tableId) {
  let input, busqueda, url;
  url = "/buscando-poliza";

  input = document.getElementById("search");
  busqueda = input.value.toUpperCase();
  const filtro =  document.getElementById("filtro").value

  const dataPeticion = { busqueda,filtro };
  const headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
  };

  try {
    const response = await axios.post(url, dataPeticion, { headers });
    if (!response.status) {
      console.log(`HTTP error! status: ${response.status} 😭`);
    }

    if (response.data.fin === 0) {
      $(`#${tableId} tbody`).html("");
      $(`#${tableId} tbody`).html(`
      <tr>
        <td colspan="6" style="text-align:center;color: red;font-weight: bold;">No resultados para la busqueda: <strong style="text-align:center;color: #222;">${busqueda}</strong></td>
      </tr>`);
      return false;
    }

    if (response.data) {
      $(`#${tableId} tbody`).html("");
      let miData = response.data;
      $(`#${tableId} tbody`).append(miData);
    }
  } catch (error) {
    console.error(error);
  }
}


async function buscadorTableA(tableId) {
  let input, busqueda, url;
  url = "/buscando-asegurado";

  input = document.getElementById("search");
  busqueda = input.value.toUpperCase();
  const filtro =  document.getElementById("filtro").value

  const dataPeticion = { busqueda,filtro };
  const headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
  };

  try {
    const response = await axios.post(url, dataPeticion, { headers });
    if (!response.status) {
      console.log(`HTTP error! status: ${response.status} 😭`);
    }

    if (response.data.fin === 0) {
      $(`#${tableId} tbody`).html("");
      $(`#${tableId} tbody`).html(`
      <tr>
        <td colspan="6" style="text-align:center;color: red;font-weight: bold;">No resultados para la busqueda: <strong style="text-align:center;color: #222;">${busqueda}</strong></td>
      </tr>`);
      return false;
    }

    if (response.data) {
      $(`#${tableId} tbody`).html("");
      let miData = response.data;
      $(`#${tableId} tbody`).append(miData);
    }
  } catch (error) {
    console.error(error);
  }
}


