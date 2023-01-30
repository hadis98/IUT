import sys
from copy import deepcopy

num_propagations = 0
num_splits = 0
true_value_set = set()
false_value_set = set()


def print_CNF_form(cnf):
    message = ''
    for clause in cnf:
        if len(clause):
            message += '(' + clause.replace(' ', '+') + ')'
    if message == '':
        message = '()'
    print('cnf = '+message)


def print_result(is_satisfiable):
    global true_value_set, false_value_set
    print(f"""
    number of unit propagations:{num_propagations}
    number of splits in tree:{num_splits}
    """)

    if is_satisfiable:
        print('SAT problem is satisfiable\nSolution of Problem is ')
        for literal in true_value_set:
            print(f'{literal} = TRUE')

        for literal in false_value_set:
            print(f'{literal} = FALSE')

    else:
        print('******** SAT problem is not satisfiable ********')


def read_input_file():
    input_file = open(sys.argv[1], 'r').read()
    cnf = input_file.splitlines()
    literals = get_alphabet_literals(cnf)
    print("cnf: ", cnf)
    print("literals: ", literals)
    return cnf, literals


def dpll_solve(cnf, alphabet_literals):
    global num_splits, num_propagations, true_value_set, false_value_set
    num_splits += 1
    print_CNF_form(cnf)
    temp_true_set = []
    temp_false_set = []
    true_value_set = set(true_value_set)
    false_value_set = set(false_value_set)
    cnf = list(set(cnf))
    units = find_units(cnf)
    print('Units =', units)
    for unit in units:
        num_propagations += 1
        if '!' in unit:
            temp_false_set.append(unit[-1])
            cnf = handle_unit_propagation_false(cnf, unit)
        else:
            temp_true_set.append(unit)
            cnf = handle_unit_propagation_true(cnf, unit)    
    print('\nCNF after calling unit propogation = ', cnf, '\n')

    if len(cnf) == 0:
        return True

    if is_empty_clause(cnf):
        handle_backtrack(temp_true_set, temp_false_set)
        return False

    alphabet_literals = get_alphabet_literals(cnf)
    selected_literal = alphabet_literals[0]
    if dpll_solve(deepcopy(cnf)+[selected_literal], deepcopy(alphabet_literals)):
        return True
    elif dpll_solve(deepcopy(cnf)+['!'+selected_literal], deepcopy(alphabet_literals)):
        return True
    else:
        remove_assigned_values(temp_true_set, temp_false_set)
        return False


def find_units(cnf):
    found_units = []
    for clause in cnf:
        if len(clause) < 3: 
            found_units.append(clause)

    return list(set(found_units))  # to remove possible duplications


def handle_unit_propagation_false(cnf, unit):  # cnf is an array
    global false_value_set
    alphabet_literal = unit[-1]
    false_value_set.add(alphabet_literal)
    # loop through all clauses to find this literal or its ~
    clause_counter = 0
    while True:
        if unit in cnf[clause_counter]:
            # delete clause with this literal in it
            cnf.remove(cnf[clause_counter])
            clause_counter -= 1
        elif alphabet_literal in cnf[clause_counter]:
            cnf[clause_counter] = cnf[clause_counter].replace(
                alphabet_literal, '').strip()
        clause_counter += 1
        if clause_counter >= len(cnf):
            break
    return cnf


def handle_unit_propagation_true(cnf, unit):
    global true_value_set
    true_value_set.add(unit)
    clause_counter = 0
    while True:
        if '!'+unit in cnf[clause_counter]:
            cnf[clause_counter] = cnf[clause_counter].replace(
                '!'+unit, '').strip()
            if '  ' in cnf[clause_counter]:
                cnf[clause_counter] = cnf[clause_counter].replace('  ', ' ')
        elif unit in cnf[clause_counter]:
            cnf.remove(cnf[clause_counter])
            clause_counter -= 1
        clause_counter += 1
        if clause_counter >= len(cnf):
            break
    return cnf


def is_empty_clause(cnf):
    counter = 0
    for clause in cnf:
        if len(clause) == 0:
            counter += 1
    if counter > 0:
        return True
    return False


def handle_backtrack(temp_true_set, temp_false_set):
    global true_value_set, false_value_set
    for alphabet_literal in temp_true_set:
        true_value_set.remove(alphabet_literal)
    for alphabet_literal in temp_false_set:
        false_value_set.remove(alphabet_literal)
    print('#########  Null clause found, backtracking occured  #########')


def get_alphabet_literals(cnf):
    alphabet_literals_list = []
    cnf_str = ''.join(cnf)
    for alphabet in list(set(cnf_str)):
        if alphabet.isalpha():
            alphabet_literals_list.append(alphabet)
    return alphabet_literals_list


def remove_assigned_values(temp_true_set, temp_false_set):
    global true_value_set, false_value_set
    for literal in temp_true_set:
        if literal in true_value_set:
            true_value_set.remove(literal)

    for literal in temp_false_set:
        if literal in false_value_set:
            false_value_set.remove(literal)


def run_dpll_algorithm():
    print('\n\nrunning dpll algorithm....')
    cnf, literals = read_input_file()
    is_satisfiable = dpll_solve(cnf, literals)
    print_result(is_satisfiable)


if __name__ == '__main__':
    run_dpll_algorithm()
