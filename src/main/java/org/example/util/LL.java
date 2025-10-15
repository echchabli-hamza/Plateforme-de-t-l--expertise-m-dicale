package org.example.util;

import java.io.FileWriter;
import java.io.PrintWriter;

public class LL {


    private static final String LOG_FILE = "/home/hamza/ProjectsLogs/show.txt";



    public static void to(String m){


        try {


            FileWriter fw = new FileWriter(LOG_FILE, true);
            PrintWriter pw = new PrintWriter(fw);

            pw.println(m);
            pw.close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }


}
