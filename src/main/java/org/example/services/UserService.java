package org.example.services;

import jakarta.servlet.ServletContext;
import org.example.UserDTO;
import org.example.entities.Creneau;
import org.example.entities.SpecialistProfile;
import org.example.entities.User;
import org.example.repositories.UserRepository;
import org.example.util.LL;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Logger;

import static java.util.stream.Collectors.toList;

public class UserService {


    private UserRepository ur ;

    private static final String LOG_FILE = "/home/hamza/ProjectsLogs/show.txt";



    public UserService(ServletContext context){

        ur = new UserRepository(context);



    }

    public List<Creneau> getUser(Long id){

        return ur.findById(id).getCreneaux().stream().filter(e->e.getDisponible()==true).toList();


    }

    public List<User> getSp(String role , double tarif){

        List<User> ll =  ur.getSpecial();



        return ll.stream()
                .filter(e -> e.getSpecialistProfile().getSpecialite().equals(role))
                .filter(e->e.getSpecialistProfile().getTarif()<=tarif)
                .map(e -> {
                    e.setConsultations(null);
                    e.setTeleExpertises(null);
                    return e;
                })
                .toList();

    }


//     public List<UserDTO> getSp(String role , double tarif){
//
//         List<User> ll =  ur.getSpecial();
//
//
//
//         return ll.stream()
//                 .peek(e ->{LL.to(e.getId().toString()) ; LL.to(e.getSpecialistProfile().getSpecialite()) ;})
//                 .filter(e -> e.getSpecialistProfile().getSpecialite().equals(role))
//                 .filter(e->e.getSpecialistProfile().getTarif()<=tarif)
//                 .map(e ->{
//                 UserDTO ud  =  new UserDTO(e.getId(), e.getUsername(), e.getFullName(), e.getRole());
//                     LL.to(ud.toString());
//                     return ud;})
//                 .toList();
//
//     }

}


//         try (FileWriter fw = new FileWriter(LOG_FILE, true);
//              PrintWriter pw = new PrintWriter(fw)) {
//             pw.println(" the role to filter is : " + role);
//             for (User e : ll) {
//                 pw.println("[UserService]  : " + e.getUsername() + "spe  :" + e.getSpecialistProfile().getSpecialite() );
//             }
//         } catch (IOException ex) {
//             ex.printStackTrace();
//         }