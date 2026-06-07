path = r'c:\Users\dalec\Desktop\app aseguradora\my-app\templates\public\Cobranza\Lista_pagos.html'
with open(path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

found = False
for i, line in enumerate(lines):
    if 'initialPagos = {{ pagos | tojson | safe' in line:
        print(f"Found at line {i+1}")
        lines[i] = '        const initialPagos = {{ pagos | tojson | safe }};\n'
        if i+1 < len(lines) and '}};' in lines[i+1]:
             print(f"Removing line {i+2}")
             lines[i+1] = ''
        found = True
        break

if found:
    with open(path, 'w', encoding='utf-8', newline='') as f:
        f.writelines(lines)
    print("Success")
else:
    print("Not found")
