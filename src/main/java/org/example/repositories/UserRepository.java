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
    private EntityManager em;


    public UserRepository(ServletContext context) {
        EntityManagerFactory emf = (EntityManagerFactory) context.getAttribute("emf");
        this.em = emf.createEntityManager();

    }



    public void save(User user) {
        em.persist(user);
    }

    public User update(User user) {
        return em.merge(user);
    }

    public void delete(User user) {
        em.remove(em.contains(user) ? user : em.merge(user));
    }

    public User findById(Long id) {
        em.clear();
        return em.find(User.class, id);
    }

    public User findByUsername(String username) {
        List<User> users = em.createQuery(
                        "SELECT u FROM User u WHERE u.username = :username", User.class)
                .setParameter("username", username)
                .getResultList();
        return users.isEmpty() ? null : users.get(0);
    }

    public List<User> getSpecial(){

        return em.createQuery("SELECT u from User u WHERE u.role= 'SPECIALISTE' " , User.class).getResultList();
    }


    public List<User> findAll() {
        return em.createQuery("SELECT u FROM User u", User.class).getResultList();
    }
}
