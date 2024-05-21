package modules.usuarios;




public class Usuario {

    private long id;
    private String username;
    private String password;
    private String email;
    
    
    public Usuario(long id, String username, String email, String password){
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public boolean equals(Object obj) {
        return obj!=null && 
            obj.getClass() == this.getClass() && 
            ((Usuario)obj).getId() == this.id;
    }

    /** toString
     * 
     * @return Devuelve una cadena que identifica al Usuario
     */
    @Override
    public String toString() {
        return String.format(
            "%3d: %10s %10s, %20s", 
            id, username, email, password);
    }
}
