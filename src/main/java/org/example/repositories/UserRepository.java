package org.example.repositories;

import jakarta.persistence.EntityManagerFactory;
import jakarta.servlet.ServletContext;
import org.example.entities.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

@Transactional
public class UserRepository {

    @PersistenceContext(unitName = "TeleExpertisePU")

    private EntityManagerFactory emf;


    public UserRepository(ServletContext context) {
         emf = (EntityManagerFactory) context.getAttribute("emf");
        EntityManager em = emf.createEntityManager();

    }



    public void save(User user) {
        EntityManager em = emf.createEntityManager();
        em.persist(user);
    }

    public User update(User user) {
        EntityManager em = emf.createEntityManager();
        return em.merge(user);
    }

    public void delete(User user) {
        EntityManager em = emf.createEntityManager();
        em.remove(em.contains(user) ? user : em.merge(user));
    }

    public User findById(Long id) {
        EntityManager em = emf.createEntityManager();
        return em.find(User.class, id);
    }

    public User findByUsername(String username) {
        EntityManager em = emf.createEntityManager();
        List<User> users = em.createQuery(
                        "SELECT u FROM User u WHERE u.username = :username", User.class)
                .setParameter("username", username)
                .getResultList();
        return users.isEmpty() ? null : users.get(0);
    }

    public List<User> getSpecial(){
        EntityManager em = emf.createEntityManager();
        return em.createQuery("SELECT u from User u WHERE u.role= 'SPECIALISTE' " , User.class).getResultList();
    }


    public List<User> findAll() {
        EntityManager em = emf.createEntityManager();
        return em.createQuery("SELECT u FROM User u", User.class).getResultList();
    }
}
