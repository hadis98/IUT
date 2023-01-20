from queue import Queue
import pandas as pd

cities_en_dic = {
    "اراک": 'Arak',
    "اردبیل": 'Ardebil',
    "ارومیه": 'Urumie',
    "اصفهان": 'Isfahan',
    "اهواز": 'Ahwaz',
    "ایلام": 'Ilam',
    "بجنورد": 'Bojnurd',
    "بندرعباس": 'BandarAbbas',
    "بوشهر": 'bushehr',
    "بیرجند": 'Birjand',
    "تبریز": 'Tabriz',
    "تهران": 'Tehran',
    "خرم آباد": 'KhoramAbad',
    "رشت": 'Rasht',
    "زاهدان": 'Zahedan',
    "زنجان": 'Zanjan',
    "ساری": 'Sari',
    "سمنان": 'Semnan',
    "سنندج": 'Sanandaj',
    "شهرکرد": 'Shahrekord',
    "شیراز": 'Shiraz',
    "قزوین": 'Ghazvin',
    "قم": 'Ghom',
    "کرج": 'Karaj',
    "کرمان": 'Kerman',
    "کرمانشاه": 'Kermanshah',
    "گرگان": 'Gorgan',
    "مشهد": 'Mashhad',
    "همدان": 'Hamedan',
    "یاسوج": 'Yasuj',
    "یزد": 'Yazd'
}
adjacency_list_cities = {}
shortest_distance_dic = {}
global df_real_distance
global df_shortest_distance
global df_neighbours_state

REAL_DISTANCE_FILE_PATH = "./data_excel_files/ProvinceCenterDistances.xlsx"
SHORTEST_DISTANCE_FILE_PATH = "./data_excel_files/ProvinceCentersStraightLineDistances.xlsx"
NEIGHBOURS_STATE_FILE_PATH = "./data_excel_files/ProvinceCentersNeighbours.xlsx"


def is_city_valid(selected_city):
    return selected_city in cities_en_dic.values()


def is_cities_neighbour(source_city, destination_city):
    for row in df_neighbours_state.index:
        if (row == source_city):
            for column in df_neighbours_state:
                if (column == destination_city):
                    if (df_neighbours_state[row][column] == 1):
                        return True
                    else:
                        return False


def init_adjacency_dic():
    for row in df_real_distance.index:
        en_city_name = cities_en_dic[row]
        adjacency_list_cities[en_city_name] = []


def compute_adjaceny_list():
    for row in df_real_distance.index:
        en_source_city_name = cities_en_dic[row]
        for column in df_real_distance.columns:
            en_destination_city_name = cities_en_dic[column]
            exact_cities_distance = df_real_distance[row][column]
            if (is_cities_neighbour(row, column)):
                adjacency_list_cities[en_source_city_name].append(
                    (en_destination_city_name, exact_cities_distance))


def compute_shortest_distance_dic():
    for row in df_shortest_distance.index:
        en_source_city_name = cities_en_dic[row]
        for column in df_shortest_distance.columns:
            en_destination_city_name = cities_en_dic[column]
            shortest_cities_distance = df_shortest_distance[row][column]
            shortest_distance_dic[f'{en_source_city_name},{en_destination_city_name}'] = shortest_cities_distance


def get_shortest_distance(source_city, destination_city):
    return shortest_distance_dic[f'{source_city},{destination_city}']


def get_real_distance(source_city, destination_city):
    adjacent_cities = adjacency_list_cities[source_city]
    for (city, real_distance) in adjacent_cities:
        if (city == destination_city):
            return real_distance


def get_city_neighbors(selected_city):
    if (is_city_valid(selected_city)):
        return adjacency_list_cities[selected_city]


def compute_total_travel_distance(traveled_path):
    if (traveled_path == None):
        return

    total_travel_distance = 0
    for index in range(len(traveled_path)-1):
        first_city = traveled_path[index]
        second_city = traveled_path[index+1]
        total_travel_distance += get_real_distance(first_city, second_city)

    return total_travel_distance


def read_excel_files():
    global df_real_distance, df_shortest_distance, df_neighbours_state

    df_real_distance = pd.read_excel(
        REAL_DISTANCE_FILE_PATH, index_col=0)
    df_shortest_distance = pd.read_excel(
        SHORTEST_DISTANCE_FILE_PATH, index_col=0)
    df_neighbours_state = pd.read_excel(
        NEIGHBOURS_STATE_FILE_PATH, index_col=0)


def a_star_search_algorithm(source_city, destination_city):
    if (is_city_valid(source_city) == False or is_city_valid(destination_city) == False):
        return

    open_list = set([source_city])
    closed_list = set([])
    g = {}
    g[source_city] = 0
    parents = {}
    parents[source_city] = source_city

    while len(open_list) > 0:
        n = None
        # find a node with the lowest value of f() - evaluation function
        for v in open_list:
            if n == None or g[v] + get_shortest_distance(v, destination_city) < g[n] + get_shortest_distance(n, destination_city):
                n = v

        if n == None:
            print('Path does not exist!')
            return None

        if n == destination_city:
            reconst_path = []

            while parents[n] != n:
                reconst_path.append(n)
                n = parents[n]

            reconst_path.append(source_city)
            reconst_path.reverse()
            return reconst_path

        # for all neighbors of the current node do
        for (adjacent_city, real_distance) in get_city_neighbors(n):
            # if the current node isn't in both open_list and closed_list
            # add it to open_list and note n as it's parent
            if adjacent_city not in open_list and adjacent_city not in closed_list:
                open_list.add(adjacent_city)
                parents[adjacent_city] = n
                g[adjacent_city] = g[n] + real_distance

            else:
                if g[adjacent_city] > g[n] + real_distance:
                    g[adjacent_city] = g[n] + real_distance
                    parents[adjacent_city] = n

                    if adjacent_city in closed_list:
                        closed_list.remove(adjacent_city)
                        open_list.add(adjacent_city)

        open_list.remove(n)
        closed_list.add(n)

    print('Path does not exist!')
    return None


def bfs_search_algorithm(source_city, destination_city):
    visited_cities = []
    queue = Queue()
    queue.put(source_city)
    visited_cities.append(source_city)
    parents = {}
    parents[source_city] = None

    does_path_exist = False
    while not queue.empty():
        current_city = queue.get()
        if (current_city == destination_city):
            does_path_exist = True
            break

        for (adjacent_city, real_distance) in get_city_neighbors(current_city):
            if (adjacent_city not in visited_cities):
                queue.put(adjacent_city)
                parents[adjacent_city] = current_city
                visited_cities.append(adjacent_city)

    path = []
    if does_path_exist:
        path.append(destination_city)
        while parents[destination_city] is not None:
            path.append(parents[destination_city])
            destination_city = parents[destination_city]
        path.reverse()
    return path


def init_configs():
    read_excel_files()
    init_adjacency_dic()
    compute_adjaceny_list()
    compute_shortest_distance_dic()


def log_travel_info(source_city, destination_city):
    traveled_path_a_star = a_star_search_algorithm(
        source_city, destination_city)
    traveled_path_bfs = bfs_search_algorithm(
        source_city, destination_city)
    print('Traveled Path with \n1.a_star approach: {}\n2.bfs approach: {}'.format(
        traveled_path_a_star, traveled_path_bfs))

    total_traveled_distance_a_star = compute_total_travel_distance(
        traveled_path_a_star)
    total_traveled_distance_bfs = compute_total_travel_distance(
        traveled_path_bfs)
    print('\ntotal distance from {} to {} is \n1.a_star approach: {}\n2.bfs approach: {}\n'.format(
        source_city, destination_city, total_traveled_distance_a_star, total_traveled_distance_bfs))


init_configs()
log_travel_info('Hamedan', 'Tehran')
log_travel_info('Arak', 'Ardebil')
log_travel_info('Arak', 'BandarAbbas')
log_travel_info('Isfahan', 'Mashhad')
