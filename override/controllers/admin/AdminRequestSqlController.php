<?php

class AdminRequestSqlController extends AdminRequestSqlControllerCore
{

	/**
	 * Genrating a export file
	 * Patched by Madman
	 * Changes the delimiter from ; to ,
	 * Filename is now Name of the sql request and current date
	 */
	public function generateExport()
	{
		if (!($obj = $this->loadObject(true)))
			return;
		$name = $obj->name;
		$obj = nil;
		$id = Tools::getValue($this->identifier);
		if (!Validate::isFileName($id))
			die(Tools::displayError());
// 		$file = 'request_sql_'.$id.'.csv';
		$file = $name . "_" .  date("Y-m-d") . '.csv';
		if ($csv = fopen(_PS_ADMIN_DIR_.'/export/'.$file, 'w'))
		{
			$sql = RequestSql::getRequestSqlById($id);

			if ($sql)
			{
				$results = Db::getInstance()->executeS($sql[0]['sql']);
				foreach (array_keys($results[0]) as $key)
				{
					$tab_key[] = $key;
					fputs($csv, $key.';');
				}
				foreach ($results as $result)
				{
					fputs($csv, "\n");
					foreach ($tab_key as $name)
						fputs($csv, '"'.strip_tags($result[$name]).'";');
				}
				if (file_exists(_PS_ADMIN_DIR_.'/export/'.$file))
				{
					$filesize = filesize(_PS_ADMIN_DIR_.'/export/'.$file);
					$upload_max_filesize = $this->returnBytes(ini_get('upload_max_filesize'));
					if ($filesize < $upload_max_filesize)
					{
						if (Configuration::get('PS_ENCODING_FILE_MANAGER_SQL'))
							$charset = Configuration::get('PS_ENCODING_FILE_MANAGER_SQL');
						else
							$charset = self::$encoding_file[0]['name'];

						header('Content-Type: text/csv; charset='.$charset);
						header('Cache-Control: no-store, no-cache');
						header('Content-Disposition: attachment; filename="'.$file.'"');
						header('Content-Length: '.$filesize);
						readfile(_PS_ADMIN_DIR_.'/export/'.$file);
						die();
					}
					else
						$this->errors[] = Tools::DisplayError('The file is too large and can not be downloaded. Please use the clause "LIMIT" in this query.');
				}
			}
		}
	}

}

