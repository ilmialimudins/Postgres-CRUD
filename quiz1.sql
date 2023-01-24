-- 1. Jumlah department tiap region
SELECT c.region_id, count(d.department_id)
FROM departments d 
INNER JOIN locations l
	ON d.location_id = l.location_id
INNER JOIN countries c
	ON l.country_id = c.country_id
GROUP BY c.region_id
ORDER BY c.region_id;

-- 2. Jumlah department tiap countries
SELECT l.country_id, count(d.department_id)
FROM departments d
INNER JOIN locations l
	ON d.location_id = l.location_id
GROUP BY l.country_id;

-- 3. Jumlah employee tiap departemen
SELECT d.department_id, d.department_name, count(employee_id) jumlah_employee
FROM departments d
INNER JOIN employees e
	ON e.department_id = d.department_id
GROUP BY d.department_id
ORDER BY d.department_id;

-- 4. Jumlah employee tiap region
SELECT c.region_id, count(e.employee_id) jumlah_employee
FROM employees e
INNER JOIN departments d
	ON e.department_id = d.department_id
INNER JOIN locations l
	ON d.location_id = l.location_id
INNER JOIN countries c
	ON l.country_id = c.country_id
GROUP BY c.region_id;

-- 5. Jumlah employee tiap country
SELECT l.country_id, count(e.employee_id)
FROM employees e
INNER JOIN departments d
	ON e.department_id = d.department_id
INNER JOIN locations l
	ON d.location_id = l.location_id
GROUP BY l.country_id;

-- 6. Salary tertinggi tiap department
SELECT department_id, max(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- 7. Salary terendah tiap department
SELECT department_id, min(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- 8. Salary rata-rata tiap department
SELECT department_id, avg(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- 9. Jumlah mutasi pegawai tiap departemen
SELECT d.department_id, d.department_name, count(h.employee_id)
FROM job_history h
INNER JOIN departments d
	ON d.department_id = h.department_id
GROUP BY d.department_id;

-- 10. Informasi jumlah mutasi pegawai berdasarkan role-jobs.
SELECT job_id, count(employee_id)
FROM job_history
GROUP BY job_id;

-- 11. Informasi jumlah employee yang sering dimutasi.
SELECT count(jumlah_mutasi)
FROM (
	SELECT employee_id, COUNT(employee_id) n
	FROM job_history
	GROUP BY employee_id
) AS jumlah_mutasi
WHERE n > 1;

-- 12. Informasi jumlah employee berdasarkan role jobs-nya.
SELECT j.job_title, count(e.employee_id)
FROM employees e
INNER JOIN jobs j
	ON e.job_id = j.job_id
GROUP BY j.job_title;

-- 13. Informasi employee paling lama bekerja di tiap departemen
SELECT CONCAT(e2.first_name, ' ', e2.last_name), e2.department_id, e2.hire_date
FROM (
	SELECT department_id, MIN(hire_date) min_hire_date
	FROM employees
	GROUP BY department_id
	ORDER BY department_id
	) e1
INNER JOIN employees e2
ON e1.department_id = e2.department_id
WHERE e2.hire_date = min_hire_date
ORDER BY e1.department_id

-- 14. Informasi employee baru masuk kerja di tiap department
SELECT CONCAT(e2.first_name, ' ', e2.last_name), e2.department_id, e2.hire_date
FROM (
	SELECT department_id, MAX(hire_date) max_hire_date
	FROM employees
	GROUP BY department_id
	ORDER BY department_id
	) e1
INNER JOIN employees e2
ON e1.department_id = e2.department_id
WHERE e2.hire_date = max_hire_date
ORDER BY e1.department_id;

-- 15. Informasi lama bekerja tiap employee dalam tahun dan jumlah mutasi history-nya
SELECT 
	e.employee_id,
	(SELECT EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM e.hire_date)) lama_kerja,
	CASE
		WHEN jumlah_mutasi IS NULL THEN 0
		ELSE jumlah_mutasi
	END
FROM employees e
LEFT JOIN (SELECT employee_id, count(employee_id) jumlah_mutasiFROM job_history GROUP BY employee_id) mutasi
	ON e.employee_id = mutasi.employee_id
ORDER BY e.employee_id