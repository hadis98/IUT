// create a table to show instructions:
const row_items = ['Elements', 'Initial Values', 'T0: AR <- PC', 'T1: IR <- M[AR], PC <-PC+1', 'T2: AR <- IR[0:11]', 'T3', 'T4', 'T5', 'T6', 'After Execution'];
const column_items = ['statements', 'IR', 'AC', 'DR', 'PC', 'AR', 'M[AR]', 'E'];
const inst_table = document.createElement('table');
const inst_table_container = document.querySelector('.instruction-table');
for (let i = 0; i < 10; i++) {
    let row = document.createElement('tr');
    for (let j = 0; j < 8; j++) {
        let column = document.createElement('td');
        if (j !== 0) {
            column.classList.add('text-center'); //every elemetn except first column
        }
        if (i == 0) {
            column.innerText = column_items[j];
            column.classList.add('bold-text');
        }
        if (j == 0) {
            column.innerText = row_items[i];
            column.classList.add('bold-text');
            column.classList.add('info-column');
        }
        row.appendChild(column);
    }
    inst_table.appendChild(row);
}
inst_table_container.appendChild(inst_table);


// create a memory table
const memoryTable = document.createElement('table');
const memoryTable__container = document.querySelector('.memory-table');
for (let i = -1; i < 4097; i++) {
    let row = document.createElement('tr');
    for (let j = 0; j < 3; j++) {
        let column = document.createElement('td');
        if (i == -1) {
            if (j == 0) {
                column.innerText = 'Decimal Addrress';
            } else if (j == 1) {
                column.innerText = 'Hex Addrress';
            } else if (j == 2) {
                column.innerText = 'Contents';
            }
            column.classList.add('bold-text');
            row.classList.add('sticky-header');
        } else if (j == 0) {
            column.innerText = i;
            column.classList.add('bold-text');
        } else if (j == 1) {
            column.innerText = DecToHex_address(i);
            column.classList.add('bold-text');
        }
        column.classList.add('text-center');
        row.appendChild(column);
    }
    memoryTable.appendChild(row);
}
memoryTable__container.appendChild(memoryTable);

const table = document.querySelector('.memory-table table');
const rows = table.getElementsByTagName('tr');
const columns = table.getElementsByTagName('td');

function updateContentsColumn() {
    let counter = startAddress;
    for (let i = parseInt('0x' + startAddress) + 1; i < parseInt('0x' + startAddress) + numberOfAddress + 1; i++) {
        columns[i * 3 + 2].innerText = memory_table_contents[counter];
        counter = addHexNumbers(counter, '1');
    }
    scrollToRow(parseInt('0x' + startAddress) + 1);
}

function update_memory_table(address) {
    let index = parseInt('0x' + address) + 1;
    columns[index * 3 + 2].innerText = writeHexNum(memory_table_contents[address]);
    columns[index * 3 + 2].classList.add('appear-content');
}

function scrollToRow(number) {
    const table = document.querySelector('.memory-table table');
    const rows = table.getElementsByTagName('tr');
    table.scrollTop = rows[number - 2].offsetTop;
}

// instruction table
const instructionTable = document.querySelector('.instruction-table table');
const inst_rows = instructionTable.getElementsByTagName('tr');
const inst_columns = instructionTable.getElementsByTagName('td');

function updateInstructionTable(value) {
    let column = 0; //switch case?
    if (value == 'initial') {
        column = 9;
    } else if (value == 'T0') {
        column = 17
    } else if (value == 'T1') {
        column = 25
    } else if (value == 'T2') {
        column = 33;
    } else if (value == 'T3') {
        column = 41;
    } else if (value == 'T4') {
        column = 49;
    } else if (value == 'T5') {
        column = 57;
    } else if (value == 'T6') {
        column = 65;
    } else if (value == 'final') {
        column = 73;
    }
    for (const key in instr_values) {
        inst_columns[column].innerText = instr_values[key];
        column++;
    }
}

function clearInstTable() {
    counter = 17;
    for (let i = 0; i < 8; i++) {
        for (let column = counter; column <= counter + 6; column++) {
            inst_columns[column].innerText = '';
        }
        counter += 8;
    }

}