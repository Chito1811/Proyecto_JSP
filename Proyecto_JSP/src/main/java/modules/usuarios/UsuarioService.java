package modules.usuarios;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import modules.crud.CRUD;

import java.sql.PreparedStatement; 
/** UsuarioService
 * Clase que implementa la interfaz CRUD para la tabla Usuario
 * Funciona como un servicio de acceso a datos para el model Usuario
 */
public class UsuarioService implements CRUD<Usuario>{
    // Conexión activa con la base de datos
    private Connection conn;

    /** UsuarioService (Constructor)
     * Constructor que crea la instancia del servicio y
     * almacena la conexión a la base de datos 
     * @param conn Conexión con la base de datos
     */
    public UsuarioService(Connection conn){
        this.conn = conn;
    }


    @Override
    public ArrayList<Usuario> query(String column, String value) throws SQLException {
        ArrayList<Usuario> listaUsuarios = new ArrayList<>();
        Statement statement = null;
        statement = this.conn.createStatement();
        String sql = String.format("SELECT * FROM Usuarios WHERE %s='%s'", column, value);
        ResultSet resultado = statement.executeQuery(sql);
        while (resultado.next()) {
            int id = resultado.getInt(1);
            String username = resultado.getString(2);
            String email = resultado.getString(3);
            String password = resultado.getString(4);
            listaUsuarios.add(new Usuario(id, username, email, password));
        }
        statement.close();
        return listaUsuarios;
    }

    @Override
    public ArrayList<Usuario> requestAll(String sortedBy) throws SQLException {
        ArrayList<Usuario> listaUsuarios = new ArrayList<>();
        Statement statement = null;
        statement = this.conn.createStatement();
        String sql = "SELECT * FROM Usuarios";
        ResultSet resultado = statement.executeQuery(sql);
        while (resultado.next()) {
            int id = resultado.getInt(1);
            String username = resultado.getString(2);
            String email = resultado.getString(3);
            String password = resultado.getString(4);
            listaUsuarios.add(new Usuario(id, username, email, password));
        }
        statement.close();
        return listaUsuarios;
    }

    @Override
    public Usuario requestById(long id) throws SQLException {
        ArrayList<Usuario> listaUsuarios = this.requestAll("");
        for (Usuario user: listaUsuarios){
            if (user.getId()==id){
                return user;
            }
        }
        return null;
    }

    @Override
    public long create(Usuario model) throws SQLException {
        PreparedStatement prepst = null;
        String sql = String.format("INSERT INTO Usuarios(username, email, password) VALUES (?,?,?)");
        prepst = this.conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        prepst.setString(1, model.getUsername());
        prepst.setString(2, model.getEmail());
        prepst.setString(3, model.getPassword());
        prepst.executeUpdate();
        ResultSet keys = prepst.getGeneratedKeys();
        if(keys.next()){    
            int id = keys.getInt(1);    
            prepst.close();
            return id;
        } 
        else{
            prepst.close();
            throw new SQLException("No se ha podido crear el Usuario.");
        }
    }

    @Override
    public int update(Usuario object) throws SQLException {
        Statement statement = null;
        statement = this.conn.createStatement();
        String sql = String.format("UPDATE Usuarios SET username='%s', password='%s', email='%s' WHERE id=%d", object.getUsername(), object.getPassword(), object.getEmail(), object.getId());
        int affectedrows = statement.executeUpdate(sql);
        if (affectedrows==0){
            throw new SQLException("No se ha podido actualizar el Usuario, no han habido filas afectadas.");
        }
        statement.close();
        return affectedrows;
    }

    @Override
    public boolean delete(long id) throws SQLException {
        Statement statement = null;
        statement = this.conn.createStatement();
        String sql = String.format("DELETE FROM Usuarios WHERE id=%d", id);
        int affectedrows = statement.executeUpdate(sql);
        if (affectedrows==0){
            throw new SQLException("No se ha podido eliminar el Usuario, no han habido filas afectadas.");
        }
        statement.close();
        return affectedrows==1;
    }


    
}
