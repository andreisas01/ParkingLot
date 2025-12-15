package com.parking.parkinglot.ejb;

import com.parking.parkinglot.common.UserDto;
import com.parking.parkinglot.entities.User;
import com.parking.parkinglot.entities.UserGroup;
import jakarta.ejb.EJBException;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.annotation.security.RolesAllowed;

import java.util.Collection;
import java.util.logging.Logger;
import java.util.List;

@Stateless
public class UsersBean {
    private static final Logger LOG = Logger.getLogger(UsersBean.class.getName());

    @PersistenceContext
    EntityManager entityManager;

    @Inject
    PasswordBean passwordBean;

    public List<UserDto> findAllUsers() {
        LOG.info("findAllUsers");
        try {
            TypedQuery<User> typedQuery = entityManager.createQuery("SELECT u FROM User u", User.class);
            List<User> users = typedQuery.getResultList();
            return copyCarsToDto(users);
        } catch (Exception e) {
            throw new EJBException(e);
        }
    }

    public List<UserDto> copyCarsToDto(List<User> users) {
        return users.stream()
                .map(user -> new UserDto(
                        user.getId(),
                        user.getEmail(),
                        user.getUsername(),
                        user.getPassword()))
                .toList();
    }

    @RolesAllowed({"WRITE_USERS"})
    public void createUser(String username, String email, String password, Collection<String> groups) {
        LOG.info("createUser");

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        String hashedPassword = passwordBean.convertToSha256(password);
        user.setPassword(hashedPassword);
        entityManager.persist(user);

        assignGroupsToUser(username, groups);
    }

    public Collection<String> findUsernamesByUserIds(Collection<Long> userIds) {
        LOG.info("findUsernamesByUserIds");
        List<String> usernames = entityManager.createQuery(
                "SELECT u.username FROM User u WHERE u.id IN :userIds", String.class)
                .setParameter("userIds", userIds)
                .getResultList();
        return usernames;
    }

    void assignGroupsToUser(String username, Collection<String> groups) {
        LOG.info("assignGroupsToUser");
        for (String group : groups) {
            UserGroup userGroup = new UserGroup();
            userGroup.setUsername(username);
            userGroup.setUserGroup(group);
            entityManager.persist(userGroup);
        }
    }
}