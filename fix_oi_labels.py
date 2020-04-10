import os
import argparse

# Traverse the folders
# Walking a directory tree and printing the names of the directories and files
# If a txt file is found then replace class names inside with class index

# Input: A folder full of labels for open images with labels on the 12 objects from requirements
# Task 1: Make two new seperate folders with the same labels
# Task 2: In the coco labels, if the label is not in the coco dataset then delete it,
#           if the label is in the dataset, then change the index to match the coco index for that class.
# Task 3: In the wmg labels, delete any label that is not head or glasses.
# Output: 2 new folders - one containing adjusted labels for the COCO dataset, another contain the wmg dataset


parser = argparse.ArgumentParser(description='Traverse directory of training data and replace class names with relevant index')
parser.add_argument("-d", "--dataset", required=True, help="Specify a path to the dataset")
# parser.add_argument("-d", "--location", required=True, help="Specify a path to the base directory to traverse")

args = parser.parse_args()

dataset = args.dataset

print("Searching labels folder")
# Traverse and replace names
for dirpath, dirnames, files in os.walk(dataset):
    for file_name in files:
        file_path = os.path.join(dirpath, file_name)
        if '.txt' in file_path:
            print("Opening " + file_name)
            
            # Open and read annotations from txt file
            fin =  open(file_path, 'rt')
            print("Read data...")
            data = fin.readlines()
            fin.close()

            print("Before replace: ")
            for line in data:
                print(line)

            for i in range(len(data)):
                #print("Before replace: " + line)

                data[i] = data[i].rstrip()
                data[i] = data[i].replace("Glasses", "566")
                data[i] = data[i].replace("Remote control", "595")
                data[i] = data[i].replace("Mobile phone", "313")
                data[i] = data[i].replace("Coat", "118")
                data[i] = data[i].replace("Backpack", "38")
                data[i] = data[i].replace("Handbag", "404")
                data[i] = data[i].replace("Person", "67")
                data[i] = data[i].replace("Human head", "291")
                data[i] = data[i].replace("Countertop", "441")
                data[i] = data[i].replace("Table", "280")
                data[i] = data[i].replace("Coffee table", "377")
                data[i] = data[i].replace("Sofa bed", "245")
                data[i] = data[i].replace("Chair", "96")
                #print("After replace: " + line)

            print("After replace: ")
            for line in data:
                print(line)
            
            # Overwrite file
            fout = open(dataset + file_name, 'wt')
            for line in data:
                fout.write(line+'\n')
            fout.close()
