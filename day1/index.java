package day1;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

class Main {
    public static void main(String args[]) {
        File inputFile = new File("./day1/input.txt");
        Scanner reader;
        try {
            reader = new Scanner(inputFile);
        } catch(FileNotFoundException e) {
            System.out.println("file not found");
            return;
        }
        int input[] = new int[2000]; 
        for(int i = 0; i < 2000; i++) {
            input[i] = Integer.parseInt(reader.nextLine());
        }
        reader.close();

        int count = 0;
        for(int i = 1; i < input.length; i++) {
            if(input[i-1] < input[i]) {
                count++;
            }
        }
        System.out.println(count);

        count = 0;
        for(int i = 3; i < input.length; i++) {
            if(input[i-3] < input[i]) {
                count++;
            }
        }
        System.out.println(count);
    }
}