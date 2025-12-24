SELECT
    driverId,
    number,
    driverRef
from {{ ref('drivers') }}