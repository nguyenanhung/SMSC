package io.smsc.model.projections;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.smsc.model.crud.CrudClassMetaData;
import io.smsc.model.crud.CrudMetaGridData;
import io.smsc.model.crud.MetaDataPropertyBindingParameter;
import org.springframework.data.rest.core.config.Projection;

import java.util.Date;
import java.util.Set;

/**
 * This interface is describing excerpting projection for {@link CrudMetaGridData}
 * entity and is used for fetching relation properties in JSON response.
 *
 * @author  Nazar Lipkovskyy
 * @see     Projection
 * @since   0.0.1-SNAPSHOT
 */
@Projection(name = "crud-meta-grid-data", types = { CrudMetaGridData.class })
public interface CrudMetaGridDataProjection {

    Long getId();

    Long getVersion();

    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="GMT")
    Date getLastModifiedDate();

    String getProperty();

    Boolean getEditable();

    Boolean getVisible();

    String getDecorator();

    Double getOrder();

    String getType();

    String getLinkedClass();

    String getLinkedRepository();

    Double getColumnWidth();

    Set<MetaDataPropertyBindingParameter> getBindingParameters();

    CrudClassMetaData getCrudClassMetaData();
}