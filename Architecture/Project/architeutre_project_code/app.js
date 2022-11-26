// instructions

// memory instructions
// only we define opcodes here
const memory_instructions = {
    AND: [0, 8],
    ADD: [1, 9],
    LDA: [2, "A"],
    STA: [3, "B"],
    BUN: [4, "C"],
    BSA: [5, "D"],
    ISZ: [6, "E"],
};

// registor instructions
const register_instructions = {
    CLA: "7800",
    CLE: "7400",
    CMA: "7200",
    CIR: "7080",
    CIL: "7040",
    INC: "7020",
    SPA: "7010",
    SNA: "7008",
    SZA: "7004",
    SZE: "7002",
    HLT: "7001",
};

// input output instructions
const IO_instructions = {
    INP: "F800",
    OUT: "F400",
    SKI: "F200",
    SKO: "F100",
    ION: "F080",
    IOF: "F040",
};

//REGISTERS
let AC = '0000000000000000';
let DR = '0000000000000000';
let AR = '000000000000';
let IR = '0000000000000000';
let PC = '000000000000';
let TR = '0000000000000000';
let INPR = '00000000';
let OUTR = '00000000';

//FLAGS
let FGO = 0; //outup flag
let FGI = 0; //input flag

let IEN = 0; // Interrup enable

let I = 0;
let SC = 0;
let S = 0; //start or stop
let E = 0;
let Cout = 0;
let opcode_operation;
let operation_code;
let current_clock = '';
let numberOfAddress = 0;
let startAddress = 0;

const labels_table = {};
const memory_table_contents = {};
const memory_table_address = {};
const assemblerBtn = document.getElementById("assemblerBtn");
let editor_contents;
let results;
let results_index = 0;
let operations_line = 0;

const errorLine = document.getElementById('error_line');
const errorLineBtn = document.getElementById('errorLineBtn');
const errorLine_container = document.getElementById('errorLine_container');
const assemble_successfully = document.getElementById('assembled_successfully_container');
const assembled_successfully_Btn = document.getElementById('assembled_successfully_Btn');
// let instructions_arr = [];
// firt level of simulations:

// line counter
let LC = '0x0';

// in this function we calculate label_table and check every line of codes in editor
function firstStep() {
    LC = '0x0';
    results_index = 0;
    for (let i = 0; i < results.length; i++) {
        scanEveryLine_first();
    }
}

function secondStep() {
    errorLine.innerText = '';
    numberOfAddress = 0;
    LC = '0x0';
    results_index = 0;
    for (let i = 0; i < results.length; i++) {
        scanEveryLine_second();
    }
}

// this function scans every line of codes in editor
function scanEveryLine_first() {
    let ith_line = results[results_index]; // ith line of results in string
    let results_contents = results[results_index].split(/[ ,]+/);
    if (!ith_line.includes(",")) { //dont have label:
        if (ith_line.includes("ORG")) {
            LC = writeHexNum(results_contents[1]);
        } else {
            if (ith_line.includes("END")) {
                // start second step
            } else {
                LC = addHexNumbers(LC, '1');
            }
        }
    } else {
        const symbol = results_contents[0];
        labels_table[symbol] = LC.substr(1, 3);
        LC = addHexNumbers(LC, '1');
    }

    results_index++; //be ready to scan next line
}

function scanEveryLine_second() {
    let ith_line = results[results_index];
    let results_contents = results[results_index].split(/[ ,]+/);
    if (
        ith_line.includes("ORG") ||
        ith_line.includes("END") ||
        ith_line.includes("HEX") ||
        ith_line.includes("DEC")
    ) {
        if (ith_line.includes("ORG")) {
            LC = writeHexNum(results_contents[1]);
            startAddress = LC;
            PC = hexToBinary(LC, 12);
        } else if (ith_line.includes("END")) {
            // end of program
        } else if (ith_line.includes("HEX")) {
            if (results_contents[0] === 'HEX') {
                memory_table_contents[LC] = writeHexNum(results_contents[1]);
            } else if (results_contents[1] === 'HEX') {
                memory_table_contents[LC] = writeHexNum(results_contents[2]);
            }

            LC = addHexNumbers(LC, '1');
            numberOfAddress++;
        } else if (ith_line.includes("DEC")) {
            if (results_contents[0] === 'DEC') {
                memory_table_contents[LC] = DecToHex_contents(results_contents[1]);
            } else if (results_contents[1] === 'DEC') {
                memory_table_contents[LC] = DecToHex_contents(results_contents[2]);
            }
            LC = addHexNumbers(LC, '1');
            numberOfAddress++;
        }
    } else if (ith_line.includes(',') &&
        !ith_line.includes("HEX") &&
        !ith_line.includes("DEC")) {
        let target = results_contents[1];

        if (search_in_object(memory_instructions, target)) {
            let opcode; //x
            if (results_contents.includes('I')) {
                opcode = memory_instructions[target][1]; //x
            } else {
                opcode = memory_instructions[target][0]; //x
            }
            let address;
            let variable = results_contents[2];
            address = labels_table[variable]; //xxx
            let full_address = opcode.toString() + address.toString();
            memory_table_contents[LC] = full_address;
            LC = addHexNumbers(LC, '1');
            numberOfAddress++;

        } else if (search_in_object(register_instructions, target)) {
            let opcode = register_instructions[target];
            memory_table_contents[LC] = opcode;
            LC = addHexNumbers(LC, '1');
            numberOfAddress++;

        } else if (search_in_object(IO_instructions, target)) {
            let opcode = IO_instructions[target];
            memory_table_contents[LC] = opcode;
            LC = addHexNumbers(LC, '1');
            numberOfAddress++;
        }

    } else {
        // if it is memory refrence:
        let target = results_contents[0];
        if (search_in_object(memory_instructions, target)) {
            if (!search_in_object(labels_table, results_contents[1])) {
                errorLine_container.style.display = 'flex';
                boxShadow.classList.add('show');
                errorLine.innerText = LC;
            } else {
                // if it is memory instruction:
                // format: instruction label or format: instruction label I
                let opcode; //x
                if (results_contents.includes('I')) {
                    opcode = memory_instructions[target][1]; //x
                } else {
                    opcode = memory_instructions[target][0]; //x
                }
                let address;
                let variable = results_contents[1];
                address = labels_table[variable]; //xxx
                let full_address = opcode.toString() + address.toString();
                memory_table_contents[LC] = full_address;
                LC = addHexNumbers(LC, '1');
                numberOfAddress++;
            }

        } else if (search_in_object(register_instructions, target)) {
            let opcode = register_instructions[target];
            memory_table_contents[LC] = opcode;
            LC = addHexNumbers(LC, '1');
            numberOfAddress++;

        } else if (search_in_object(IO_instructions, target)) {
            let opcode = IO_instructions[target];
            memory_table_contents[LC] = opcode;
            LC = addHexNumbers(LC, '1');
            numberOfAddress++;
        } else {
            console.log('waaaaaaaaaaarning!!!! in line: ' + LC + ' of memory');
            console.log('instruction doesnt exist');
            errorLine_container.style.display = 'flex';
            boxShadow.classList.add('show');
            errorLine.innerText = LC;
            LC = addHexNumbers(LC, '1');
            numberOfAddress++;
        }
    }
    results_index++;
}

function search_in_object(object, target) {
    for (let i = 0; i < Object.keys(object).length; i++) {
        if (object[target]) {
            return object[target];
        }
    }
    return 0;
}

function DecToHex(decimal) { // Data (decimal)

    length = -1; // Base string length
    string = ''; // Source 'string'

    characters = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F']; // character array

    do { // Grab each nibble in reverse order because JavaScript has no unsigned left shift

        string += characters[decimal & 0xF]; // Mask byte, get that character
        ++length; // Increment to length of string

    } while (decimal >>>= 4); // For next character shift right 4 bits, or break on 0

    decimal += 'x'; // Convert that 0 into a hex prefix string -> '0x'

    do
        decimal += string[length];
    while (length--); // Flip string forwards, with the prefixed '0x'

    return decimal; // return (hexadecimal);
}

function DecToHex_address(decimal) {
    let hex = DecToHex(decimal);
    let result;
    if (hex.length < 5) {
        let addedArr = [];
        for (let i = 0; i < 5 - hex.length; i++) {
            addedArr.push("0");
        }
        let arr = hex.split('');
        arr.splice(2, 0, ...addedArr);
        result = arr.join('');
        hex = result;
    }
    if (hex.length > 5) {
        hex = hex.split('').slice(-4).join('');
    }
    return hex;

}

function DecToHex_contents(number) {
    let hex = DecToHex(number);
    if (hex.length > 4) {
        hex = hex.split('').slice(-4).join('');
    } else if (hex.slice(2).length <= 4) {
        let number_of_zero = '';
        for (let i = 0; i < 4 - hex.slice(2).length; i++) {
            number_of_zero += '0';
        }
        hex = hex.split('').slice(-hex.slice(2).length).join('');
        hex = number_of_zero + hex;
    }
    return hex;

}

function writeHexNum(hex_number) {
    if (hex_number.length <= 4) {
        let number_of_zero = '';
        for (let i = 0; i < 4 - hex_number.length; i++) {
            number_of_zero += '0';
        }
        hex_number = number_of_zero + hex_number;
        return hex_number
    }
}

function setHexFormat(number) {
    return number = '0x'.concat(number);
}

function addHexNumbers(c1, c2) {
    var hexStr = (parseInt(c1, 16) + parseInt(c2, 16)).toString(16).toUpperCase();
    while (hexStr.length < 4) { hexStr = '0' + hexStr; } // Zero pad.
    return hexStr;
}

const error_line = document.getElementById('error-line');
const errors_div = document.querySelector('.errors');
const boxShadow = document.querySelector('.box-shadow');
const close_empty_error = document.getElementById('emptyBtn');


function start_assemble() {
    const strings = document.getElementById("editor").value;
    if (strings == "") {
        errors_div.style.display = 'flex';
        boxShadow.classList.add('show');
    } else {
        editor_contents = strings;
        results = editor_contents.split("\n");
        firstStep();
        secondStep();
        if (errorLine.innerText == '') {
            assemble_successfully.style.display = 'flex';
            boxShadow.classList.add('show');
            console.log(labels_table);
            console.log(memory_table_contents);
            updateContentsColumn();
            assemblerBtn.disabled = true;
            assemblerBtn.style.backgroundColor = 'rgb(4, 153, 153)';
            instr_values['Memory'] = '0x' + binaryToHex(PC);
            instr_values['PC'] = '0x' + binaryToHex(PC);
            updateInstructionTable('initial');
            enableBtn(fetchBtn);
        }
    }
}

// get contents of editor
// click on assemble button
assemblerBtn.addEventListener("click", start_assemble);
close_empty_error.addEventListener('click', () => {
    errors_div.style.display = 'none';
    boxShadow.classList.remove('show');
})

errorLineBtn.addEventListener('click', () => {
    errorLine_container.style.display = 'none';
    boxShadow.classList.remove('show');
})

assembled_successfully_Btn.addEventListener('click', () => {
    assemble_successfully.style.display = 'none';
    boxShadow.classList.remove('show');
})

// ***************************  EXAMPLES  *************************************
/**
ORG 100
LDA SUB
CMA
INC
ADD MIN
STA DIF
HLT
MIN, DEC 83
SUB, DEC -23
DIF, HEX 0
END
 */

/*
ORG 100
LOP, CLE
LDA Y
CIR
STA Y
SZE
BUN ONE
BUN ZRO
ONE, LDA X
ADD P
STA P
CLE
ZRO, LDA X
CIL
STA X
ISZ CTR
BUN LOP
HLT
CTR, DEC -8
X, HEX F
Y, HEX B
P, HEX 0
END
*/

/*
ORG 100
LDA X
BSA OR
HEX 140
STA Y
HLT
X, HEX 150
Y, HEX 0
OR, HEX 0
CMA
STA TMP
LDA OR I
CMA
AND TMP
CMA
ISZ OR
BUN OR I
TMP, HEX 0
END
*/

/*
ORG 100
LDA X
BSA SH4
STA X
LDA Y
BSA SH4
STA Y
HLT
X, HEX 1234
Y, HEX 4321
SH4, HEX 0
CIL
CIL
CIL
CIL
AND MSK
BUN SH4 I
MSK, HEX FFF0
END
 */

/*
ORG 100
LDA AL
ADD BL
STA CL
CLA
CIL
ADD AH
ADD BH
STA CH
HLT
AL, DEC 12
AH, DEC 32
BL, DEC 40
BH, DEC 02
CL,DEC 0
CH, DEC 0
END
*/